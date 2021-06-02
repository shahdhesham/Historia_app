import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
class Predict extends StatefulWidget {
  //   String name;
  // Predict(this.name);
  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  File _image;
  double _imageWidth;
  double _imageHeight;
  var _recognitions;

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/SEgypt.tflite",
        labels: "assets/Egypt_label.txt",
      );
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  // run prediction using TFLite on given image
  Future predict(File image) async {
    print("//////////////////////////////////////////////");
    print("predict");
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 224, // defaults to 117.0
        imageStd: 1.0, // defaults to 1.0
        numResults: 4, // defaults to 5
        threshold: 0.005, // defaults to 0.1
        asynch: true // defaults to true
        );
    print("//////////////////////////////////////////////");

    print(recognitions);
    print("//////////////////////////////////////////////");

    setState(() {
      _recognitions = recognitions;
    });
  }
  // String name='';

  // send image to predict method selected from gallery or camera
  sendImage(File image) async {
    if (image == null) return;
    print("object");
    await predict(image);

    // get the width and height of selected image
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _image = image;
          });
        })));
  }

  // select image from gallery
  selectFromGallery() async {
    final picker = ImagePicker();
    PickedFile image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
    _image = File(image.path);
    sendImage(_image);
    print("here");
  }

  // select image from camera
  selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {});
    sendImage(image);
  }

  @override
  void initState() {
    super.initState();

    loadModel().then((val) {
      setState(() {});
    });
  }

  Widget printValue(rcg) {
    
    if (rcg == null) {
      return Text('',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    } else if (rcg.isEmpty) {
      return Center(
        child: Text("Could not recognize",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }
   
    //  widget.name = (_recognitions[0]['label'].toString().toUpperCase());
    // print(widget.name);
     
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Center(
        child: Text(
          "Prediction: " +
              _recognitions[0]['label'].toString().toUpperCase(),
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
    //}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double finalW;
    double finalH;

    // when the app is first launch usually image width and height will be null
    // therefore for default value screen width and height is given
    if (_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    } else {
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      finalW = _imageWidth * ratioW * .85;
      finalH = _imageHeight * ratioH * .50;
    }

//    List<Widget> stackChildren = [];

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Detection",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: printValue(_recognitions),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: _image == null
                  ? Center(
                      child: Text("Select image from camera or gallery"),
                    )
                  : Center(
                      child: Image.file(_image,
                          fit: BoxFit.fill, width: finalW, height: finalH)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    height: 50,
                    width: 150,
                    color: Colors.redAccent,
                    child: FlatButton.icon(
                      onPressed: selectFromCamera,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      color: Colors.deepPurple,
                      label: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  color: Colors.tealAccent,
                  child: FlatButton.icon(
                    onPressed: selectFromGallery,
                    icon: Icon(
                      Icons.file_upload,
                      color: Colors.white,
                      size: 30,
                    ),
                    color: Colors.blueAccent,
                    label: Text(
                      "Gallery",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                ),
              ],
            ),
            Row(
              children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                      child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'TextAudio');
                    },
                    icon: Icon(Icons.library_books_rounded),
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

