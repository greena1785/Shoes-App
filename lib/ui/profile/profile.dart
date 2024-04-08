import 'package:flutter/material.dart';
import 'package:shoes_app/firebaseService/firebase_service.dart';
import 'package:shoes_app/model/user.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // Add userId as a required parameter

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseService _service = FirebaseService();
  UserData? _user; // Make _user nullable since getUserData returns UserData?

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    UserData? userData = await _service.getUserData(widget.userId);
    setState(() {
      _user = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user != null) // Check if _user is not null before accessing its properties
              Column(
                children: [
                  Text(
                    'Welcome, ${_user!.name}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Email: ${_user!.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _service.logout();
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
