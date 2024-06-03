import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';
  String _error = '';

  Future<void> _changePassword() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Re-authenticate the user to verify the current password
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Change the password
        await user.updatePassword(_newPassword);
        // Password changed successfully
        // You can show a success message or navigate to a different page
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Password changed successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Password change failed. Please try again.';
        if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect current password.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'The new password is too weak.';
        }
        setState(() {
          _error = errorMessage;
        });
      } catch (e) {
        setState(() {
          _error = 'Password change failed. Please try again.';
        });
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/app_backing.png"),
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
                TextFormField(
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Existing/Current Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _currentPassword = value;
                    });
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newPassword = value;
                    });
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm the new password';
                    }
                    if (value != _newPassword) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword = value;
                    });
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _changePassword();
                    }
                  },
                  child: const Text('Change Password'),
                ),
                const SizedBox(height: 8.0),
                Text(
                  _error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
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
