import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:ui_gp/providers/auth.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: 'Notifications',
              subtitle: 'Enabled',
              leading: Icon(Icons.notifications),
              onTap: () {},
            ),
          ]),
          SettingsSection(
            tiles: [
              SettingsTile(
                title: 'Country',
                subtitle: 'Egypt',
                leading: Icon(Icons.location_city),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            tiles: [
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.logout),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
