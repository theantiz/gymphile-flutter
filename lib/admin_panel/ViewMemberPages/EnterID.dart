import 'package:flutter/material.dart';
import 'package:gymphile/admin_panel/ViewMemberPages/ViewMember.dart';

class EnterID extends StatefulWidget {
  @override
  _EnterIDState createState() => _EnterIDState();
}

class _EnterIDState extends State<EnterID> {
  final TextEditingController _idController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _navigateToViewDataPage() {
    if (_formKey.currentState!.validate()) {
      String documentId = _idController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMember(documentId: documentId),
        ),
      );
      _idController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Member ID'),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'Member ID',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid ID';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _navigateToViewDataPage,
                  child: Text('View Data'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
