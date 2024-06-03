import 'package:flutter/material.dart';
import 'package:gymphile/admin_panel/AddDataPage.dart';
import 'package:gymphile/admin_panel/RemoveMember.dart';
import 'package:gymphile/admin_panel/ViewMemberPages/EnterID.dart';
import 'package:gymphile/admin_panel/updateMember.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Section'),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddDataPage()));
                },
                child: const Text('Add Member'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UpdateMember()));
                },
                child: const Text('Edit Member'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RemoveMember()));
                },
                child: const Text('Remove Member'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => EnterID()));
                },
                child: const Text('View Member'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
