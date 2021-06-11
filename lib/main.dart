import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_gp/screens/ForgetPassword.dart';
import 'package:ui_gp/functionalties/TextAudio.dart';
import 'package:ui_gp/screens/User_home.dart';
import 'package:ui_gp/functionalties/predict.dart';
import 'package:ui_gp/providers/auth.dart';
import 'package:ui_gp/providers/monuments.dart';
import 'package:ui_gp/functionalties/scann.dart';
import 'package:ui_gp/screens/admin.dart';
import 'package:ui_gp/screens/auth_screen.dart';
import 'package:ui_gp/screens/crudmonument.dart';
import 'package:ui_gp/screens/faq.dart';
import 'package:ui_gp/screens/monumentDetail.dart';
import 'package:ui_gp/screens/monumentsMenu.dart';
import 'package:ui_gp/screens/profile.dart';
import 'package:ui_gp/functionalties/video.dart';
import 'package:ui_gp/widgets/settings.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Auth(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProxyProvider<Auth, Monuments>(
            create: (_) => Monuments(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId, []),
            update: (ctx, auth, monuments) =>
                monuments..receiveToken(auth, monuments.items),
          ),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  theme: ThemeData(
                    primaryColor: Colors.black,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home:
                      //AuthScreen(),
                      auth.isAuth
                          ? UserHome()
                          : FutureBuilder(
                              future: auth.autoLogin(),
                              builder: (ctx, autResSnapshot) =>
                                  autResSnapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? AuthScreen()
                                      : AuthScreen(),
                            ),
                  routes: {
                    'forgetpass': (context) => ForgetPassword(),
                    'userhome': (context) => UserHome(),
                    'predict': (context) => Predict(),
                    'TextAudio': (context) => TextAudio(),
                    'scann': (context) =>
                        DetectScreen(title: 'Detect Monument'),
                    'video': (context) => Video(images: <Image>[]),
                    'admin': (context) => AdminPage(),
                    'monuments': (context) => MonumentsMenu(),
                    'monument-detail': (context) => MonumentDetail(),
                    'edit-monument': (context) => CrudMonument(),
                    'settings': (context) => SettingsPage(),
                    'FAQs': (context) => FAQPage(),
                    'profile': (context) =>
                        ProfileApp(auth.userName, auth.email),
                  },
                )));
  }
}
