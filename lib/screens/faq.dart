import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: Container(
        child: ListView(
          children: const <Widget>[
            Card(
                child: ListTile(
                    title: Text('What is Historia?',
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,\n\n when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,\n\n but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            ),
            Card(
                child: ListTile(
                    title: Text(
              'How can I use Historia?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ))),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,\n\n when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,\n\n but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Card(
                child: ListTile(
                    title: Text('Do you have special offers?',
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys\n standard dummy text ever since the 1500s,\n\n when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,\n\n but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            ),
            Card(
                child: ListTile(
                    title: Text('How do I add an item as a favorite?',
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys\n standard dummy text ever since the 1500s,\n\n when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries\n\n, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            ),
          ],
        ),
      ),
    );
  }
}
