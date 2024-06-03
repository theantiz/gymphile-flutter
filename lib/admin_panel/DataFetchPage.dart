import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataFetchPage extends StatefulWidget {
  @override
  _DataFetchPageState createState() => _DataFetchPageState();
}

class _DataFetchPageState extends State<DataFetchPage> {
  TextEditingController docIdController = TextEditingController();

  @override
  void dispose() {
    docIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Attendance'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/app_backing.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: docIdController,
                decoration: InputDecoration(
                  labelText: 'Member ID',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String docId = docIdController.text.trim();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataDisplayPage(docId: docId),
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataDisplayPage extends StatelessWidget {
  final String docId;

  const DataDisplayPage({required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Attendance'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('att').doc(docId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.data!.exists) {
            return const Center(
              child: Text('No data found.'),
            );
          }

          Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;

          // Display the fetched data
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('img/app_backing.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          Text('Date: ${data?['date']}'),
                          const SizedBox(height: 8.0),
                          Text('Day: ${data?['day']}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
