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
            title: Text('Wise Food '),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('Profile'),
            onTap: () => Navigator.pushNamed(context, 'profile'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Recommendations'),
            onTap: () => Navigator.pushNamed(context, 'recommend'),
          ),
          ListTile(
            leading: Icon(Icons.group_work),
            title: Text('Cuisines'),
            onTap: () => Navigator.pushNamed(context, 'cuisines'),
          ),
          ListTile(
            leading: Icon(Icons.add_sharp),
            title: Text('Join Us'),
            onTap: () => Navigator.pushNamed(context, 'join us'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.pushNamed(context, 'settings'),
          ),
          ListTile(
            leading: Icon(Icons.help_center),
            title: Text('FAQs'),
            onTap: () => Navigator.pushNamed(context, 'faqs'),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () => Navigator.pushNamed(context, 'help'),
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
