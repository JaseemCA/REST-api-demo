import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text('user details'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user['email'];
            final name = user['name']['first'];
            final imageurl = user['picture']['thumbnail'];

            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(imageurl)),
              title: Text(name.toString()),
              subtitle: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        backgroundColor: Colors.amber,
      ),
    );
  }

  void fetchUsers() async {
    // print('user fetched');
    const url = 'https://randomuser.me/api/?results=15';
    final uri = Uri.parse(url);
    //uniformResourseIdentifier=uri
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    // print('fetchUser complete');
  }
}
