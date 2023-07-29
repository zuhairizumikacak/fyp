import 'package:flutter/material.dart';
import 'pertama_screen.dart';
import 'login_admin.dart';

class InterfaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Type Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Code to handle the user click
                showUserTypeDialog(context, isUser: true);
              },
              child: Text('Are you a user? Click here'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Code to handle the admin click
                showUserTypeDialog(context, isUser: false);
              },
              child: Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }

  void showUserTypeDialog(BuildContext context, {bool isUser = true}) {
    Navigator.of(context).pop(); // Close the dialog
    if (isUser) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PertamaScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: InterfaceScreen(),
  ));
}
