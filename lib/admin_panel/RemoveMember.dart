import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoveMember extends StatefulWidget {
  @override
  _RemoveMemberState createState() => _RemoveMemberState();
}

class _RemoveMemberState extends State<RemoveMember> {
  final TextEditingController _idController = TextEditingController();

  Future<void> _deleteDocument() async {
    String id = _idController.text;

    if (id.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a valid ID'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('member').doc(id).get();

      if (documentSnapshot.exists) {
        await FirebaseFirestore.instance.collection('member').doc(id).delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Member removed'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Member not found'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove member'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Member'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/app_backing.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'Member ID',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.perm_identity),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _deleteDocument,
                child: Text('Remove Member'),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
