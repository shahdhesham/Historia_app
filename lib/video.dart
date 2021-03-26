import 'dart:math';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:export_video_frame/export_video_frame.dart';
import 'package:flutter/services.dart';
import 'package:starflut/starflut.dart';


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
  String _platformVersion = 'Unknown';
  @override
  void initState() {
    super.initState();
    
  }
  var _isClean = false;
  Future _getImages() async {
    ImagePicker picker = ImagePicker();
    var file = await picker.getVideo(source: ImageSource.gallery);
    var images = await ExportVideoFrame.exportImage(file.path, 3, 0);
    var result = images.map((file) => Image.file(file)).toList();
    setState(() {
      widget.images.addAll(result);
      _isClean = true;
    });
  }

  Future _getImagesByDuration() async {
    var file = await ImagePicker.pickVideo(source: ImageSource.gallery);
    initPlatformState(
      file
    );
    var duration = Duration(seconds: 30);
    var image =
        await ExportVideoFrame.exportImageBySeconds(file, duration, pi / 2);
    setState(() {
      widget.images.add(Image.file(image));
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

  Future _handleClickSecond() async {
    if (_isClean) {
      await _cleanCache();
    } else {
      await _getImagesByDuration();
    }
  }
 Future<void> initPlatformState(video) async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      StarCoreFactory starcore = await Starflut.getFactory();
      StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
      await starcore
          .regMsgCallBackP((int serviceGroupID, int uMsg, Object wParam, Object lParam) async {
        print("$serviceGroupID  $uMsg   $wParam   $lParam");

        return null;
      });
      StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];

      /*---script python--*/
      bool isAndroid = await Starflut.isAndroid();
      if (isAndroid == true) {
        await Starflut.copyFileFromAssets(
            "testcallback.py", "starfiles", "flutter_assets/starfiles");
        await Starflut.copyFileFromAssets(
            "testpy.py", "starfiles", "flutter_assets/starfiles");
        await Starflut.copyFileFromAssets(
            "python3.6.zip", "starfiles", null); //desRelatePath must be null
        await Starflut.copyFileFromAssets("zlib.cpython-36m.so", null, null);
        await Starflut.copyFileFromAssets("unicodedata.cpython-36m.so", null, null);
        await Starflut.loadLibrary("libpython3.6m.so");
      }

      String docPath = await Starflut.getDocumentPath();
      print("docPath = $docPath");
      String resPath = await Starflut.getResourcePath();
      print("resPath = $resPath");
      dynamic rr1 = await SrvGroup.initRaw("python36", Service);

      print("initRaw = $rr1");

      var Result = await SrvGroup.loadRawModule(
          "python", "", resPath + "starfiles/" + "testpy.py", false);
      print("loadRawModule = $Result");
      dynamic python = await Service.importRawContext("python", "", "",false, "");
      print("python = " + await python.getString());
      StarObjectClass retobj = await python.call("predict", ['$video']);
      print(await retobj[0]);
      print(await retobj[1]);
      print(await python["g1"]);
      await SrvGroup.clearService();
      await starcore.moduleExit();
      platformVersion = 'Python 3.6';
    } on PlatformException catch (e) {
      print("{$e.message}");
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
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
            Expanded(
              flex: 0,
              child: Center(
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 40,
                  minWidth: 150,
                  onPressed: () {
                    _handleClickSecond();
                  },
                  color: Colors.orange,
                  child: Text("Export one image and save"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
