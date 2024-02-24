import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:read_from_text/screens/read_data_screen.dart';
import '../models/user_model.dart';

class SaveToTxtScreen extends StatefulWidget {
  const SaveToTxtScreen({super.key});

  @override
  State<SaveToTxtScreen> createState() => _SaveToTxtScreen();
}

class _SaveToTxtScreen extends State<SaveToTxtScreen> {
  final TextEditingController _description = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();

  UserModel myData = UserModel();

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/my-data-store.txt');
  }

  Future<void> saveData(UserModel data) async {
    final file = await _getFile();
    await file.writeAsString(json.encode(data));
  }

  Future<void> loadData() async {
    try {
      final file = await _getFile();
      final contents = await file.readAsString();
      setState(() {
        if(contents.isNotEmpty) {
          myData = UserModel.fromJson(json.decode(contents));
        }
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Storage')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _firstname,
                decoration: const InputDecoration(
                  labelText: "Enter First Name",
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _lastname,
                decoration: const InputDecoration(
                  labelText: "Enter Last Name",
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _description,
                decoration: const InputDecoration(
                  labelText: "Enter Description",
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                  onPressed: (){
                    log('data: ${_firstname.text.trim()}');
                    UserModel dt = UserModel();
                    dt.firstname = _firstname.text.trim();
                    dt.lastname = _lastname.text.trim();
                    dt.description = _description.text.trim();
                    saveData(dt);
                    loadData();
                  },
                  child: const Text("Save data")
              ),
              if(myData != null)
                Column(
                  children: [
                    Text(myData?.firstname ?? ''),
                    const SizedBox(height: 4),
                    Text(myData?.lastname ?? ''),
                    const SizedBox(height: 4),
                    Text(myData?.description ?? ''),
                  ],
                ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                          const ReadDataScreen(),
                        ));
                  },
                  child: const Text("Read data")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
