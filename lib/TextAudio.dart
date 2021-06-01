import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ui_gp/predict.dart';

class TextAudio extends StatefulWidget {
  static const routeName = '/extractName';
  @override
  _TextAudioState createState() => _TextAudioState();
}

class _TextAudioState extends State<TextAudio> {
    String data = '';

   fetchFileData() async {
    String responseText;
    print("tany 7eta");
    responseText = await rootBundle.loadString('assets/Hanging Church.txt');
    setState(() {
      data = responseText;
    });
  }
   @override
  void initState() {
    fetchFileData();
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context).settings.arguments as Predict;
    return Scaffold(
      
     appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Detection"+args.name,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
          
           Row(
              children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                      child: Text(data)
                  )
                  ),
            ]),
            Row(
              children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                      child: ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: Icon(Icons.volume_up_outlined),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                    ),
                    label: Text(''),
                  )
                  )
                  ),
            ])
          ],
        ));
  }
}