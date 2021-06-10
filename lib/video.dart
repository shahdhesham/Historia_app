import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:ui_gp/helpers/image_helper.dart';
import 'package:ui_gp/helpers/tflite_helper.dart';
import 'package:ui_gp/models/result.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/sharedPrefrences_helper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:export_video_frame/export_video_frame.dart';

class CountItem {
  int _counter = 0;
  var label = "";
}

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
  static List<int> _outputs = List(4);

  static var finalLabel = "";
  var _isClean = false;
  void initState() {
    Tflite.loadModel(
      model: "assets/SEgypt.tflite",
      labels: "assets/Egypt_label.txt",
    );
  }

  void disposeModel() {
    Tflite.close();
  }

  Future predict(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 224, // defaults to 117.0
        imageStd: 1.0, // defaults to 1.0
        numResults: 4, // defaults to 5
        threshold: 0.005, // defaults to 0.1
        asynch: true // defaults to true
        );
    print(recognitions);
    print(recognitions[0]);
    print(recognitions[0]['label']);
    print("reco here.//////////////////////");
    if (recognitions[0]['label'] == "Amr ibn Al-Aas Mosque") {
      _outputs[0] = _outputs[0] + 1;
    } else if (recognitions[0]['label'] == "Cavern Church- Abu Serga") {
      _outputs[1] = _outputs[1] + 1;
    } else if (recognitions[0]['label'] == "Babylon Fortress") {
      _outputs[2] = _outputs[2] + 1;
    } else if (recognitions[0]['label'] == "Hanging Church") {
      _outputs[3] = _outputs[3] + 1;
    }
  }

  Future _getImages() async {
    for (int i = 0; i < 4; i++) {
      _outputs[i] = 0;
    }
    ImagePicker picker = ImagePicker();
    var file = await picker.getVideo(source: ImageSource.gallery);

    var images = await ExportVideoFrame.exportImage(file.path, 40, 0.5);
    for (int i = 0; i < images.length; i++) {
      await predict(images[i]);
    }

    int maxIndex = 0;
    var labelPredicted = "";
    for (int i = 1; i < 4; i++) {
      if (_outputs[maxIndex] > _outputs[i]) {
        maxIndex = i;
      }
      if (maxIndex == 0) {
        labelPredicted = "Amr ibn Al-Aas Mosque";
      } else if (maxIndex == 1) {
        labelPredicted = "Cavern Church- Abu Serga";
      } else if (maxIndex == 2) {
        labelPredicted = "Babylon Fortress";
      } else if (maxIndex == 3) {
        labelPredicted = "Hanging Church";
      }
    }
    setState(() {
      _isClean = true;
      finalLabel = labelPredicted;
    });
  }

  Future _cleanCache() async {
    var result = await ExportVideoFrame.cleanImageCache();
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
