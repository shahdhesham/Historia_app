// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:ui_gp/models/monument.dart';
import 'package:ui_gp/providers/monuments.dart';

const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
final validatePhone = RegExp(pattern);

class crudMonument extends StatefulWidget {
  static const routeName = 'edit-store';
  @override
  _crudMonumentState createState() => _crudMonumentState();
}

class _crudMonumentState extends State<crudMonument> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  ///image Picker
  final _formKey = GlobalKey<FormState>();
  var _editedMonument = Monument(
    id: null,
    monumentName: '',
    rating: 0.0,
    number: '',
    location: '',
    imageUrl: '',
    longitude: 0.0,
    latitude: 0.0,
  );
  var _initValues = {
    'rating': 0.0,
    'number': '',
    'location': '',
    'review': '',
    'imageUrl': '',
    'Lng': 0.0,
    'Ltd': 0.0,
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final storeId = ModalRoute.of(context).settings.arguments as String;
      if (storeId != null) {
        _editedMonument =
            Provider.of<Monuments>(context, listen: false).findById(storeId);
        _initValues = {
          'id': _editedMonument.id,
          'monumentName': _editedMonument.monumentName,
          'rating': _editedMonument.rating,
          'location': _editedMonument.location,
          'number': _editedMonument.number,
          'imageUrl': _editedMonument.imageUrl,
          'Lng': _editedMonument.longitude,
          'Ltd': _editedMonument.latitude,
        };
        _imageUrlController.text = _editedMonument.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedMonument.id != null) {
      await Provider.of<Monuments>(context, listen: false)
          .updateMonument(_editedMonument.id, _editedMonument);
    } else {
      try {
        await Provider.of<Monuments>(context, listen: false)
            .addMonuments(_editedMonument);
      } catch (error) {
        print(error);
        print("??????????");
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('error'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  // File _image;
  // String _uploadedFileURL;

  // Future pickImage() async {
  //   final picker = ImagePicker();
  //   PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Restaurant'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Builder(
              builder: (context) => Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          initialValue: _initValues['storeTitle'],
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedMonument = Monument(
                              id: _editedMonument.id,
                              monumentName: value,
                              rating: _editedMonument.rating,
                              location: _editedMonument.location,
                              number: _editedMonument.number,
                              imageUrl: _editedMonument.imageUrl,
                              latitude: _editedMonument.latitude,
                              longitude: _editedMonument.longitude,
                            );
                            print('saved value is $value');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          initialValue: _initValues['location'],
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              labelText: 'Location',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z]')),
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter data';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedMonument = Monument(
                              id: _editedMonument.id,
                              monumentName: _editedMonument.monumentName,
                              rating: _editedMonument.rating,
                              location: value,
                              number: _editedMonument.number,
                              imageUrl: _editedMonument.imageUrl,
                              latitude: _editedMonument.latitude,
                              longitude: _editedMonument.longitude,
                            );
                            print('saved value is $value');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter data';
                                }

                                return null;
                              },
                              initialValue: _initValues['Lat'],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  labelText: 'Lat',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                              onSaved: (value) {
                                _editedMonument = Monument(
                                  id: _editedMonument.id,
                                  monumentName: _editedMonument.monumentName,
                                  rating: _editedMonument.rating,
                                  location: _editedMonument.location,
                                  number: _editedMonument.number,
                                  latitude: double.parse(value),
                                  longitude: _editedMonument.longitude,
                                  imageUrl: _editedMonument.imageUrl,
                                );
                                print('saved value is $value');
                              },
                            ),
                          ),
                          // ),
                          SizedBox(
                            width: 75,
                          ),
                          Expanded(
                            child: TextFormField(
                              //   inputFormatters: [
                              //   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              // ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter data';
                                }

                                return null;
                              },
                              initialValue: _initValues['Lat'],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  labelText: 'Lng',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                              onSaved: (value) {
                                _editedMonument = Monument(
                                  id: _editedMonument.id,
                                  monumentName: _editedMonument.monumentName,
                                  rating: _editedMonument.rating,
                                  location: _editedMonument.location,
                                  number: _editedMonument.number,
                                  longitude: double.parse(value),
                                  latitude: _editedMonument.latitude,
                                  imageUrl: _editedMonument.imageUrl,
                                );
                                print('saved value is $value');
                              },
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          initialValue: _initValues['number'],
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedMonument = Monument(
                              id: _editedMonument.id,
                              monumentName: _editedMonument.monumentName,
                              rating: _editedMonument.rating,
                              location: _editedMonument.location,
                              number: value,
                              imageUrl: _editedMonument.imageUrl,
                              latitude: _editedMonument.latitude,
                              longitude: _editedMonument.longitude,
                            );
                            print('saved value is $value');
                          },
                        ),
                      ),
                      //cuisines

                      //Image
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: _image == null
                      //       ? Text("no image")
                      //       : Image.file(_image),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.url,
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              labelText: "Image",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedMonument = Monument(
                              id: _editedMonument.id,
                              monumentName: _editedMonument.monumentName,
                              rating: _editedMonument.rating,
                              location: _editedMonument.location,
                              number: _editedMonument.number,
                              imageUrl: value,
                              latitude: _editedMonument.latitude,
                              longitude: _editedMonument.longitude,
                            );
                            print('saved value is $value');
                          },
                        ),
                      ),

                      //Rating

                      // Padding(
                      //     padding: const EdgeInsets.all(20.0),
                      //     child: RatingBar.builder(
                      //       initialRating: 0,
                      //       direction: Axis.horizontal,
                      //       allowHalfRating: true,
                      //       itemCount: 5,
                      //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      //       itemBuilder: (context, _) => Icon(
                      //         Icons.star,
                      //         color: Colors.amber,
                      //       ),
                      //       onRatingUpdate: (rating) {
                      //         _editedMonument = Store(
                      //           id: _editedMonument.id,
                      //           storeTitle: _editedMonument.storeTitle,
                      //           rating: rating,
                      //           location: _editedMonument.location,
                      //           number: _editedMonument.number,
                      //           cuisine: _editedMonument.cuisine,
                      //           imageUrl: _editedMonument.imageUrl,
                      //           latitude: _editedMonument.latitude,
                      //           longitude: _editedMonument.longitude,
                      //         );
                      //       },
                      //     )),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.green[300],
                            child: MaterialButton(
                              onPressed: _saveForm,
                              child: Text('Submit'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
