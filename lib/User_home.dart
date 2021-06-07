// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ui_gp/providers/monuments.dart';
import 'package:ui_gp/widgets/drawer.dart';

class UserHome extends StatefulWidget {
  UserHome(this._userName);
  final _userName;

  static const routeName = 'userhome';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  String imageUrl;
    var _isInit = true;
  var _isLoading = true;
  
 @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Monuments>(context).fetchAndSetMonuments().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Home Page'),
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
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Historia ',
                    style: TextStyle(
                      fontFamily: 'Antens',
                      fontSize: 60,
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
                      primary: Color.fromRGBO(255, 228, 181, 1),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'scann');
                    },
                    child: Text(
                      'Start Scanning',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
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
                      primary: Color.fromRGBO(255, 228, 181, 1),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'predict');
                    },
                    child: Text(
                      'Upload Picture Offline',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
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
                      primary: Color.fromRGBO(255, 228, 181, 1),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'monuments');
                    },
                    child: Text(
                      'Available Monuments',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
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
                      primary: Color.fromRGBO(255, 228, 181, 1),
                    ),
                    onPressed: () {},
                    child: Text(
                      'My History ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
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
                      primary: Color.fromRGBO(255, 228, 181, 1),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'video');
                    },
                    child: Text(
                      'Upload Video Offline ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
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
