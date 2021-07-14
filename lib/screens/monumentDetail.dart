import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:ui_gp/providers/monuments.dart';
import 'package:ui_gp/widgets/monument/googleMaps.dart';

class MonumentDetail extends StatelessWidget {
  static const routeName = 'monument-detail';

  @override
  Widget build(BuildContext context) {
    final monumentId = ModalRoute.of(context).settings.arguments as String;
    final loadedMonument = Provider.of<Monuments>(
      context,
      listen: false,
    ).findById(monumentId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${loadedMonument.monumentName}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: double.infinity,
              child: Image.network(
                loadedMonument.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  '${loadedMonument.location}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      '  ${loadedMonument.article}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 300,
                width: 300,
                child: Maps(loadedMonument.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
