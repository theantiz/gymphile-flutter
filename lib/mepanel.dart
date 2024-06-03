import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymphile/home.dart';
import 'package:gymphile/member_panel/AttendanceScreen.dart';
import 'package:gymphile/member_panel/ViewBillsPage.dart';
import 'member_panel/ViewPdfPage.dart';
import 'settings/about.dart';
import 'member_panel/BMICalculator.dart';
import 'settings/SettingsPage.dart';

import 'member_panel/sch.dart';

class mepanel extends StatelessWidget {
  var ky;
  var d;
  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
      // You can navigate to a login page or any other page after successful logout
    } catch (e) {
      print('Failed to sign out: $e');
      // Handle sign out error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Panel'),
        titleSpacing: 1,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => about()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => home()));
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/app_backing.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => sch()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Image.asset('img/admin_ico/icon_7.png'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AttendanceScreen()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Image.asset('img/admin_ico/icon_2.png'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewBillsPage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Image.asset('img/admin_ico/icon_3.png'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewPdfPage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Image.asset('img/admin_ico/icon_5.png'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BMICalculator()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Image.asset('img/admin_ico/icon_8.png'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
