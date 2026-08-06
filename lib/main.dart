import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prayer Lockdown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Prayer Lockdown'),
        ),
        body: const Center(
          child: Text(
            'مرحباً بك في تطبيق Prayer Lockdown',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}