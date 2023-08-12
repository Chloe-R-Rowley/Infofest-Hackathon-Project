import 'package:aquaponic/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _signOut() async {
    // Clear the stored token
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');

    // Navigate to the sign-in screen
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((ctx) => const AuthScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _signOut();
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
