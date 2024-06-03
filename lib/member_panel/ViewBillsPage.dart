import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewBillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Bill'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'img/app_backing.png'), // Replace with your custom image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Below is pending membership bill',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bills')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final bills = snapshot.data?.docs;

                    if (bills!.isEmpty) {
                      return Center(
                        child: Text('No bills found.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: bills.length,
                      itemBuilder: (context, index) {
                        final bill = bills[index];

                        try {
                          final billNo = bill['billNo'];
                          final price = bill['price'];
                          final memberId = bill['memberId'];
                          final membershipDuration = bill['membershipDuration'];
                          final details = bill['details'];

                          return ListTile(
                            title: Text('Bill No: $billNo'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: $price'),
                                Text('Member ID: $memberId'),
                                Text(
                                    'Membership Duration: $membershipDuration'),
                                Text('Details: $details'),
                              ],
                            ),
                          );
                        } catch (e) {
                          return ListTile(
                            title: Text(''),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      launch(
                          'https://paytm.com'); // Replace with your desired URL
                    },
                    icon: Icon(Icons.payment),
                    label: Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
