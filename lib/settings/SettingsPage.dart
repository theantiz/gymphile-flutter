import 'package:flutter/material.dart';

import 'package:gymphile/settings/EditProfilePage.dart';
import 'ChangePasswordPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        titleSpacing: 1,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/app_backing.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'General Settings',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  // Apply dark theme text color
                  // You can modify the color based on your dark theme colors
                  // Example: color: Colors.white
                ),
              ),
              SwitchListTile(
                title: const Text(
                  'Notifications',
                  // Apply dark theme text color
                  // Example: style: TextStyle(color: Colors.white)
                ),
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text(
                  'Dark mode',
                  // Apply dark theme text color
                  // Example: style: TextStyle(color: Colors.white)
                ),
                value: _darkModeEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Account',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  // Apply dark theme text color
                  // You can modify the color based on your dark theme colors
                  // Example: color: Colors.white
                ),
              ),
              ListTile(
                title: const Text('Edit profile'),
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Change password'),
                leading: const Icon(Icons.lock),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
