import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:ui_gp/providers/monuments.dart';
import 'helpers/sharedPrefrences_helper.dart';

class TextAudio extends StatefulWidget {
  @override
  _TextAudioState createState() => _TextAudioState();
}

enum TtsState { playing, stopped, continued }

class _TextAudioState extends State<TextAudio> {
  @override
  initState() {
    // _onChange(_newVoiceText);
    super.initState();
    initTts();
    // getStringValuesSF();
  }

// String _email='';
  FlutterTts flutterTts;
  String language;
  String engine;
  double volume = 1.0;
  double pitch = 0;
  double rate = 1.0;
  bool isCurrentLanguageInstalled = false;

  // String _newVoiceText="Here  Amr ibn el ass mosque ";
  String _newVoiceText = "";

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isContinued => ttsState == TtsState.continued;

  initTts() {
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak() async {
    MySharedPreferences.instance
        .getStringValue("name")
        .then((value) => setState(() {
              _newVoiceText = value;
            }));

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(1);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(_newVoiceText);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
    MySharedPreferences.instance.removeAll();
  }

  // void _onChange(String text) {
  //   setState(() {
  //     _newVoiceText = text;
  //   });
  // }
 Future<void> _refreshMonuments(BuildContext context) async {
    await Provider.of<Monuments>(context, listen: false).fetchAndSetMonuments();
  }

  @override
  Widget build(BuildContext context) {
    MySharedPreferences.instance
        .getStringValue("name")
        .then((value) => setState(() {
          
              final loaded = Provider.of<Monuments>(
                context,
                listen: false,
              ).findByName(value);

              _newVoiceText = loaded.article;
            }));
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                "Learn More",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  _inputSection(),
                  _btnSection(),
                ]))));
  }

  Widget _inputSection() => Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: Text(_newVoiceText
          // onChanged: (String value) {
          //   _onChange(value);
          // },
          ));

  Widget _btnSection() {
    return Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
              'PLAY', _speak),
          _buildButtonColumn(
              Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
        ]));
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }
}
