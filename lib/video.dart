import 'dart:math';

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
  var _isClean = false;
  Future _getImages() async {
    ImagePicker picker = ImagePicker();
    var file = await picker.getVideo(source: ImageSource.gallery);

    var images = await ExportVideoFrame.exportImage(file.path, 35, 0.5);
    var result = images.map((file) => Image.file(file)).toList();
    setState(() {
      widget.images.addAll(result);
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
              flex: 1,
              child: GridView.extent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4),
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  children: widget.images.length > 0
                      ? widget.images
                          .map((image) => ImageItem(image: image))
                          .toList()
                      : [Container()]),
            ),
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
