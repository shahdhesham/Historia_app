import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tflite/tflite.dart';
import 'package:ui_gp/helpers/app_helper.dart';
import 'package:ui_gp/helpers/video_helper.dart';
import 'package:ui_gp/helpers/tflite_helper.dart';
import 'package:ui_gp/models/result.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:export_video_frame/export_video_frame.dart';

class ImageItem extends StatelessWidget {
  ImageItem({this.image}) : super(key: ObjectKey(image));
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(child: image);
  }
}

class Video extends StatefulWidget {
  static const routeName = 'video';
  Video({Key key, this.images}) : super(key: key);

  final List<Image> images;

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  List<Result> outputs;
  var _isClean = false;
  void initState() {
    Tflite.loadModel(
      model: "assets/Egypt.tflite",
      labels: "assets/Egypt_label.txt",
    );
  }

  void disposeModel() {
    Tflite.close();
  }

  classifyImage(var image) {
    Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            numResults: 5)
        .then((value) {
      if (value.isNotEmpty) {
        AppHelper.log("classifyImage", "Results loaded. ${value.length}");

        //Clear previous results
        outputs.clear();

        value.forEach((element) {
          outputs.add(Result(
              element['confidence'], element['index'], element['label']));

          AppHelper.log("classifyImage",
              "${element['confidence']} , ${element['index']}, ${element['label']}");
        });
      }

      //Sort results according to most confidence
      outputs.sort((a, b) => a.confidence.compareTo(b.confidence));
      print(outputs[outputs.length-1]);
    });
  }

  predictFrames(images)  {
    for (int i = 0; i < images.length; i++) {
      classifyImage(images[i]);
    }
  }

  Future _getImages() async {
    ImagePicker picker = ImagePicker();
    var file = await picker.getVideo(source: ImageSource.gallery);

    var images = await ExportVideoFrame.exportImage(file.path, 35, 0.5);
    var result = images.map((file) => Image.file(file)).toList();
    predictFrames(result);
    setState(() {
      _isClean = true;
    });
  }

  Future _cleanCache() async {
    var result = await ExportVideoFrame.cleanImageCache();
    print(result);
    setState(() {
      widget.images.clear();
      _isClean = false;
    });
  }

  Future _handleClickFirst() async {
    if (_isClean) {
      await _cleanCache();
    } else {
      await _getImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Image"),
      ),
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Center(
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 40,
                  minWidth: 100,
                  onPressed: () {
                    _handleClickFirst();
                  },
                  color: Colors.orange,
                  child: Text("Export image list"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
