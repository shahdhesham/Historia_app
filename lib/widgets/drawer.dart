import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_gp/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Historia'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushNamed(context, 'userhome'),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('Profile'),
            onTap: () => Navigator.pushNamed(context, 'profile'),
          ),
          ListTile(
            leading: Icon(Icons.add_location),
            title: Text('Monuments'),
            onTap: () => Navigator.pushNamed(context, 'monuments'),
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.pushNamed(context, 'settings'),
          ),
          ListTile(
            leading: Icon(Icons.help_center),
            title: Text('FAQs'),
            onTap: () => Navigator.pushNamed(context, 'FAQs'),
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          // Provider.of<Auth>(context, listen: false).userId ==
          //         '7iRgB1qyGYg7pskJFSHBclxbzde2'
          //     ?
          ListTile(
            title: Text('Admin'),
            onTap: () => Navigator.pushNamed(context, 'admin'),
          )
          // : ListTile(
          //     title: Text(' '),
          //   ),
        ],
      ),
    );
  }
}
