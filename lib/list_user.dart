import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:list_user_app/user_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    const url = 'https://jsonplaceholder.typicode.com/users';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        setState(() {
          users = jsonData.map((json) => User.fromJson(json)).toList();
        });
      } else {
        setState(() {
          users = [];
        });
      }
    } catch (e) {
      setState(() {
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: users.isEmpty
          ? const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading users...'),
              ],
            ))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.id} - ${user.name}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildUserInfoRow("Username:", user.username),
                        _buildUserInfoRow("Email:", user.email),
                        _buildUserInfoRow("Phone:", user.phone),
                        _buildUserInfoRow("Website:", user.website),
                        const SizedBox(height: 8),
                        const Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        _buildUserInfoRow("Street:", user.address.street),
                        _buildUserInfoRow("City:", user.address.city),
                        _buildUserInfoRow("Zipcode:", user.address.zipcode),
                        const SizedBox(height: 8),
                        const Text(
                          "Company",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        _buildUserInfoRow("Name:", user.company.name),
                        _buildUserInfoRow(
                            "Catchphrase:", user.company.catchPhrase),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildUserInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
