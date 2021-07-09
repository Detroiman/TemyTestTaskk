import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<List> getJsonFile() async {
  String url = 'https://raw.githubusercontent.com/ababicheva/FlutterInternshipTestTask/main/recipes.json';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

void main() async {
  List _dataFromGit = await getJsonFile();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
      appBar: AppBar(
        title: const Text('My Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _dataFromGit.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
            ListTile(
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
            title: Text(
              "${_dataFromGit[index]['name'][0].toString().toUpperCase()}${_dataFromGit[index]['name'].toString().substring(1)}",
              style: TextStyle(
                fontSize: 20.0,
                  fontWeight: FontWeight.bold,
              ),
            ),
            leading: new ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 86,
                maxHeight: 76,
                minHeight: 56,
                minWidth: 66,
              ),
              child: Image.network('${_dataFromGit[index]['picture']}', height: 150, width: 200, fit: BoxFit.cover,),
            ),
              trailing: Text(
                '${index+1}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

            onTap: () {
              _getInfoAboutProduct(context, "${_dataFromGit[index]['description'][0].toString().toUpperCase()}${_dataFromGit[index]['description'].toString().substring(1)}",
                  "${_dataFromGit[index]['name'][0].toString().toUpperCase()}${_dataFromGit[index]['name'].toString().substring(1)}");
            },
            subtitle: Text(
              "${_dataFromGit[index]['description'][0].toString().toUpperCase()}${_dataFromGit[index]['description'].toString().substring(1)}",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
              Divider(
                thickness: 2,
                color: Colors.grey.shade300,
                indent: 105,
              ),]
          );
        },
      ),
    ),
  ));
}

void _getInfoAboutProduct(BuildContext data, String tex, String titles) {
  var dialogWindow = new AlertDialog(
    title: new Text(titles),
    content: new Text(tex),
    actions: <Widget>[
      new TextButton(
        child: new Text("Good"),
        onPressed: () {
          Navigator.pop(data);
        },
      )
    ],
  );
  showDialog(context: data, builder: (context) => dialogWindow);
}

