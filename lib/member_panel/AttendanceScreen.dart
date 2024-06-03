import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanEnabled = true;
  bool qrCodeScanned = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController docIdController = TextEditingController();

  @override
  void dispose() {
    controller?.dispose();
    docIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Maker'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/app_backing.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200, // Adjust the size as needed
                height: 200, // Adjust the size as needed
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Enter Member ID:'),
              const SizedBox(height: 8),
              Container(
                width: 200,
                child: TextField(
                  controller: docIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Member ID',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!qrCodeScanned) {
            setState(() {
              scanEnabled = !scanEnabled;
            });
          }
        },
        child: Icon(scanEnabled ? Icons.pause : Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanEnabled && !qrCodeScanned) {
        markAttendance(scanData.code.toString());
        controller.pauseCamera(); // Pause the camera after a QR code is scanned
      }
    });
  }

  Future<void> markAttendance(String qrCodeData) async {
    if (qrCodeScanned) {
      return; // Do not process if a QR code has already been scanned
    }

    try {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Connect to Firebase Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference attendanceCollection = firestore.collection('att');

      // Get the custom document ID from the text field
      String customDocId = docIdController.text.trim();

      // Get the current date and day
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      String formattedDay = DateFormat('EEEE').format(now);

      // Create attendance document with the scanned QR code data, date, and day
      await attendanceCollection.doc(customDocId).set({
        'code': qrCodeData,
        'date': formattedDate,
        'day': formattedDay,
      });

      // Display success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Attendance marked successfully.'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error marking attendance: $e');
      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to mark attendance.'),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        qrCodeScanned =
            true; // Set the flag to indicate a QR code has been scanned
      });
    }
  }
}
