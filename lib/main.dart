import 'package:flutter/material.dart';
import 'package:list_user_app/list_user.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'List Users App',
      debugShowCheckedModeBanner: false,
      home: UserListScreen(),
    );
  }
}
