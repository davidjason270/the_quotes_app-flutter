import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = "";
  var superheros_length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse("https://type.fit/api/quotes"));

    if (response.statusCode == 200) {
      data = response.body; //get response as string

      setState(() {
        superheros_length = jsonDecode(data); //get all the data from json string superheros
      });

    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes App."),
      ),
      body: ListView.builder(
        itemCount: superheros_length == null ? 0 : 15,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(

              title: Text(jsonDecode(data)[index]['text']),
              subtitle: Text(jsonDecode(data)[index]['author']),
            ),
          );
        },
      ),
    );
  }
}
