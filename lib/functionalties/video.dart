import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:export_video_frame/export_video_frame.dart';
import '../helpers/sharedPrefrences_helper.dart';

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
  var _isloading = false;
  var isset = false;
  var finalLabel = "";
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
    setState(() {
      _isloading = true;
    });
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
      if (_outputs[i] > _outputs[maxIndex]) {
        print(_outputs[i]);
        maxIndex = i;
      }
    }
    print("max index heree");
    print(maxIndex);

    if (maxIndex == 0) {
      labelPredicted = "Amr ibn Al-Aas Mosque";
    } else if (maxIndex == 1) {
      labelPredicted = "Cavern Church- Abu Serga";
    } else if (maxIndex == 2) {
      labelPredicted = "Babylon Fortress";
    } else if (maxIndex == 3) {
      labelPredicted = "Hanging Church";
    }

    print(labelPredicted);
    String name = labelPredicted.toUpperCase();
    MySharedPreferences.instance.setStringValue("name", name);

    print(name);
    setState(() {
      _isClean = true;
      finalLabel = labelPredicted;
      _isloading = false;
      isset = true;
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
        title: Text("Upload Video"),
      ),
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: Center(
                  child: FlatButton.icon(
                    onPressed: () {
                      _handleClickFirst();
                    },
                    icon: Icon(
                      Icons.video_collection_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    color: Color.fromRGBO(255, 228, 181, 1),
                    label: Text(
                      "Upload",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            if (_isloading)
              Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "Wait While Magic is Happening",
                      style: TextStyle(
                        fontFamily: 'Antens',
                        fontSize: 40,
                        color: const Color.fromRGBO(218, 165, 32, 1),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ])
            else
              Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Center(
                        child: Container(
                          child: Text(
                            finalLabel,
                            style: TextStyle(
                              //   fontFamily: 'Antens',
                              fontSize: 40,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, 'TextAudio');
                        },
                        icon: Icon(
                          Icons.lightbulb_outline,
                          color: Colors.black,
                          size: 30,
                        ),
                        color: Color.fromRGBO(255, 228, 181, 1),
                        label: Text(
                          "Learn More",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    ),
                    if (isset)
                      Row(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 120),
                              child: Container(
                                child: FlatButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'nearBy');
                                  },
                                  icon: Icon(
                                    Icons.location_pin,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  color: Color.fromRGBO(255, 228, 181, 1),
                                  label: Text(
                                    "Nearby",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                              ),
                            )),
                      ])
                  ])
          ],
        ),
      ),
    );
  }
}
