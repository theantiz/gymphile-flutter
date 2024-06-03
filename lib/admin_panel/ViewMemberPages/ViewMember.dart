import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewMember extends StatelessWidget {
  final String documentId;

  ViewMember({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Member'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/app_backing.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('member')
              .doc(documentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.data!.exists) {
              return Center(
                child: Text('Member not found'),
              );
            }

            Map<String, dynamic> documentData = snapshot.data!.data()!;

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: documentData.entries.map((entry) {
                return Card(
                  child: ListTile(
                    title: Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(entry.value.toString()),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
