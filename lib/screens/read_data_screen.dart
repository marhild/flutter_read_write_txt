import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_model.dart';

class ReadDataScreen extends StatefulWidget {
  const ReadDataScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ReadDataScreenState();
}

class _ReadDataScreenState extends State<ReadDataScreen> {
  UserModel myData = UserModel();

  Future<File> _getFile() async{
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/my-data-store.txt');
  }

  Future<void> loadData() async{
    try{
      final file = await _getFile();
      final contents = await file.readAsString();
      setState(() {
        if(contents.isNotEmpty){
          myData = UserModel.fromJson(json.decode(contents));
        }
      });
    }catch(e){
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
        title: const Text("Data Read"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ),
      ),
    );
  }
}