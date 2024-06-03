import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymphile/admin_panel/BillPage.dart';
import 'package:gymphile/admin_panel/MemberPage.dart';
import 'package:gymphile/admin_panel/UploadPdfPage.dart';
import 'package:gymphile/admin_panel/DataFetchPage.dart';
import 'AdLog.dart';
import 'home.dart';
import 'settings/about.dart';
import 'settings/SettingsPage.dart';

class adpanel extends StatelessWidget {
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
        title: const Text('Admin Panel'),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MemberPage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Image.asset('img/admin_ico/icon_1.png'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DataFetchPage()));
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BillPage()));
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
                          builder: (context) => UploadPdfPage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Image.asset('img/admin_ico/icon_5.png'),
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
