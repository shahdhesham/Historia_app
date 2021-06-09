// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class Notifications extends StatefulWidget {
//   Notifications({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _NotificationsState createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {
//   String _messageTitle = '';
//   String _messageBody = '';
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   void register() {
//     _firebaseMessaging.getToken().then((token) => print('My token is $token'));
//   }

//   @override
//   void initState() {
//     super.initState();
//     getMessage();
//   }

//   void getMessage() {
//     _firebaseMessaging.configure(
//       onMessage: (message) async {
//         print('onMessage_________________');
//         setState(() {
//           _messageTitle = message['notification']['title'];
//           _messageBody = message['notification']['body'];
//         });
//       },
//       onResume: (message) async {
//         print('onResume_________________');
//         setState(() {
//           _messageTitle = message['notification']['title'];
//           _messageBody = message['notification']['body'];
//         });
//       },
//       onLaunch: (message) async {
//         print('onLaunch_________________');
//         setState(() {
//           _messageTitle = message['notification']['title'];
//           _messageBody = message['notification']['body'];
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Message Title: $_messageTitle',
//               ),
//               OutlineButton(
//                 child: Text('Register My Device'),
//                 onPressed: () {
//                   register();
//                 },
//               ),
//               Text(
//                 'Message Body: $_messageBody',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
