// import 'dart:html';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserHome extends StatefulWidget {
  static const routeName = 'userhome';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.gps_fixed),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.85), BlendMode.dstIn),
          ),
        ),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // (imageUrl != null)
              //     ? Image.network(imageUrl)
              //     : Image.network('https://i.imgur.com/sUFH1Aq.png'),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Welcome Helena ',
                    style: TextStyle(
                      fontFamily: 'Antens',
                      fontSize: 70,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: 200.0,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 228, 181, 0.89),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Start Scanning',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: 200.0,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 228, 181, 0.89),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'predict');
                    },
                    child: Text(
                      'Upload Offline',
                    ),
                  ),
                ),
              ),
              //  Padding(
              //   padding: const EdgeInsets.only(top: 60),
              //   child: Container(
              //     width: 200.0,
              //     height: 60,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         primary: Color.fromRGBO(255, 228, 181, 0.89),
              //       ),
              //       onPressed: () {},
              //       child: Text(
              //         'Neaby Monuments',
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: 200.0,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 228, 181, 0.89),
                    ),
                    onPressed: () {},
                    child: Text(
                      'My History ',
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  // uploadImage() async {
  //   final _firebaseStorage = FirebaseStorage.instance;
  //   final _imagePicker = ImagePicker();
  //   PickedFile image;
  //   //Check Permissions
  //   await Permission.photos.request();

  //   var permissionStatus = await Permission.photos.status;

  //   if (permissionStatus.isGranted) {
  //     //Select Image
  //     image = await _imagePicker.getImage(source: ImageSource.gallery);
  //     var file = File(image.path);

  //     if (image != null) {
  //       //Upload to Firebase
  //       var snapshot = await _firebaseStorage
  //           .ref()
  //           .child('images/imageName')
  //           .putFile(file)
  //           .onComplete;
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imageUrl = downloadUrl;
  //       });
  //     } else {
  //       print('No Image Path Received');
  //     }
  //   } else {
  //     print('Permission not granted. Try Again with permission access');
  //   }
  // }
}
