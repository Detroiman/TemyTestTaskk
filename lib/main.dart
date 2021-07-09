import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainPage(
      ),
    );
  }

}

class MainPage extends StatefulWidget{
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: new FutureBuilder(builder: (context, snapshot){
          var myData = json.decode(snapshot.data.toString());
          return new ListView.builder(
              itemCount: myData.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [

                    ListTile(
                  title: new Text(
                    'Name' + myData[index]['name'],
                    style: TextStyle(fontSize: 30),
                  ),
                  subtitle: new Text('${myData[index]['description']}',
                    style: TextStyle(fontSize: 17),),
                  minLeadingWidth: 50,
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 86,
                        maxHeight: 76,
                        minHeight: 56,
                        minWidth: 66,
                      ),
                      child: Image.network(myData[index]['picture'],
                          fit: BoxFit.cover, width: 100, height: 150),
                    ),
                  trailing: Text(
                      '${index+1}',
                  ),
                ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade300,
                    indent: 105,
                  ),
                  ]
                );
              },
              );
        },future: DefaultAssetBundle.of(context)
            .loadString('assetses/recipes.json'),),
      ),
    );
  }
}