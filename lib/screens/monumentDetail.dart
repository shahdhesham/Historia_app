import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:ui_gp/providers/monuments.dart';

class MonumentDetail extends StatelessWidget {
  static const routeName = 'store-detail';

  @override
  Widget build(BuildContext context) {
    final monumentId = ModalRoute.of(context).settings.arguments as String;
    final loadedMonument = Provider.of<Monuments>(
      context,
      listen: false,
    ).findById(monumentId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Monument Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
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
                  loadedMonument.monumentName,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('Call Us:',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(height: 10),
                    Text(
                      '  ${loadedMonument.article}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Container(
            //     child: RatingBarIndicator(
            //       rating: loadedStore.rating,
            //       itemBuilder: (context, index) => Icon(
            //         Icons.star,
            //         color: Colors.amber,
            //       ),
            //       itemCount: 5,
            //       itemSize: 30.0,
            //       direction: Axis.horizontal,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  'We are in ${loadedMonument.location}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text('Visit us:',
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 25,
                    )),
              ),
            ),
            // Container(
            //   height: 300,
            //   width: 300,
            //   child: Maps(loadedStore.id),
            // ),
          ],
        ),
      ),
    );
  }
}
