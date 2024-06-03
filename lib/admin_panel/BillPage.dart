import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  final _formKey = GlobalKey<FormState>();
  final _billNoController = TextEditingController();
  final _priceController = TextEditingController();
  final _memberIdController = TextEditingController();
  final _membershipDurationController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _billNoController.dispose();
    _priceController.dispose();
    _memberIdController.dispose();
    _membershipDurationController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _generateBill() async {
    if (_formKey.currentState!.validate()) {
      final billNo = _billNoController.text;
      final price = double.parse(_priceController.text);
      final memberId = _memberIdController.text;
      final membershipDuration = _membershipDurationController.text;
      final details = _detailsController.text;

      try {
        // Store the bill in Firebase Firestore
        await FirebaseFirestore.instance.collection('bills').doc(billNo).set({
          'billNo': billNo,
          'price': price,
          'memberId': memberId,
          'membershipDuration': membershipDuration,
          'details': details,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Clear the form
        _billNoController.clear();
        _priceController.clear();
        _memberIdController.clear();
        _membershipDurationController.clear();
        _detailsController.clear();

        // Show a success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Bill generated and stored successfully.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        // Show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to store the bill: $error'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Bill'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'img/app_backing.jpg'), // Replace with your image path
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _billNoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the bill number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Bill Number',
                        prefixIcon: const Icon(Icons.receipt),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _priceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the price';
                        }
                        if (double.tryParse(value!) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _memberIdController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the member ID';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Member ID',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _membershipDurationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the membership duration';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Membership Duration',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _detailsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the details';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Details',
                        prefixIcon: const Icon(Icons.description),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: _generateBill,
                        child: const Text('Generate Bill'),
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(fontSize: 16.0),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 36, 36, 36)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
