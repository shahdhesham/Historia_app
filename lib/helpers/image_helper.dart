import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_gp/helpers/app_helper.dart';
import 'package:ui_gp/helpers/tflite_helper.dart';
import 'package:ui_gp/models/result.dart';

class VideoHelper {
  static bool isDetecting = false;
 List<Result> images;

    static void predictFrames(images) async{

        if (!TFLiteHelper.modelLoaded) return;
        if (isDetecting) return;
        isDetecting = true;
        try {
          for(int i=0; i<images.length;i++){
          TFLiteHelper.classifyImageCamera(images[i]);}
        } catch (e) {
          print(e);
        }
     }
}
