import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class UploadPdfPage extends StatefulWidget {
  @override
  _UploadPdfPageState createState() => _UploadPdfPageState();
}

class _UploadPdfPageState extends State<UploadPdfPage> {
  File? _selectedPdf;
  TextEditingController _documentIdController = TextEditingController();

  Future<void> _uploadPdfToFirebase() async {
    if (_selectedPdf != null) {
      try {
        final fileName = path.basename(_selectedPdf!.path);
        final destination = 'pdfs/$fileName';
        final storageRef = FirebaseStorage.instance.ref().child(destination);

        final uploadTask = storageRef.putFile(_selectedPdf!);
        final snapshot = await uploadTask.whenComplete(() {});

        if (snapshot.state == TaskState.success) {
          final downloadUrl = await storageRef.getDownloadURL();
          _savePdfUrlToFirestore(downloadUrl, _documentIdController.text);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF uploaded successfully!')),
          );
        } else {
          // Handle error case
          print('Error uploading PDF');
        }
      } on FirebaseException catch (e) {
        print('Firebase Storage Error: $e');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<void> _savePdfUrlToFirestore(String url, String documentId) async {
    final docRef =
        FirebaseFirestore.instance.collection('diet').doc(documentId);
    await docRef.set({'url': url});
  }

  Future<void> _selectPdf() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (file != null) {
        setState(() {
          _selectedPdf = File(file.files.single.path!);
        });
      }
    } on PlatformException catch (e) {
      print('Error selecting PDF: $e');
    }
  }

  @override
  void dispose() {
    _documentIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload PDF'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/app_backing.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Select a Diet file to upload:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _selectPdf,
              icon: Icon(Icons.attach_file),
              label: Text('Choose Diet'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _documentIdController,
              decoration: InputDecoration(
                labelText: 'Member ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadPdfToFirebase,
              child: Text('Upload '),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
