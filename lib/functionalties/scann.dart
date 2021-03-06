import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ui_gp/helpers/app_helper.dart';
import 'package:ui_gp/helpers/camera_helper.dart';
import 'package:ui_gp/helpers/tflite_helper.dart';
import 'package:ui_gp/models/result.dart';
import 'package:ui_gp/widgets/monument/ar.dart';

class DetectScreen extends StatefulWidget {
  DetectScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetectScreenPageState createState() => _DetectScreenPageState();
}

class _DetectScreenPageState extends State<DetectScreen>
    with TickerProviderStateMixin {
  AnimationController _colorAnimController;
  Animation _colorTween;

  List<Result> outputs;

  void initState() {
    super.initState();

    //Load TFLite Model
    TFLiteHelper.loadModelCamera().then((value) {
      setState(() {
        TFLiteHelper.modelLoaded = true;
      });
    });

    //Initialize Camera
    CameraHelper.initializeCamera();

    //Setup Animation
    _setupAnimation();

    //Subscribe to TFLite's Classify events
    TFLiteHelper.tfLiteResultsController.stream.listen(
        (value) {
          value.forEach((element) {
            _colorAnimController.animateTo(element.confidence,
                curve: Curves.bounceIn, duration: Duration(milliseconds: 500));
          });

          //Set Results
          outputs = value;

          //Update results on screen
          setState(() {
            //Set bit to false to allow detection again
            CameraHelper.isDetecting = false;
          });
        },
        onDone: () {},
        onError: (error) {
          AppHelper.log("listen", error);
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<void>(
        future: CameraHelper.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: <Widget>[
                CameraPreview(CameraHelper.camera),
                _buildResultsWidget(width, outputs)
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    TFLiteHelper.disposeModel();
    CameraHelper.camera.dispose();
    AppHelper.log("dispose", "Clear resources.");
    super.dispose();
  }

  Widget _buildResultsWidget(double width, List<Result> outputs) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: width,
          color: Colors.white,
          child: outputs != null &&
                  outputs.isNotEmpty &&
                  outputs[outputs.length - 1].confidence > 0.7
              ? ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Text(
                          outputs[outputs.length - 1].label,
                          style: TextStyle(
                            //   color: _colorTween.value,
                            fontSize: 40.0,
                            //   style: TextStyle(
                            // fontFamily: 'Antens',
                            // fontSize: 40,
                          ),
                        ),
                      ],
                    );
                  })
              : Center(
                  child: Text("Wating for model to detect..",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ))),
        ),
      ),
    );
  }

  void _setupAnimation() {
    _colorAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _colorTween = ColorTween(begin: Colors.green, end: Colors.red)
        .animate(_colorAnimController);
  }
}
