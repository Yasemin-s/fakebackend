import 'dart:convert';

import 'package:fake_backend/model/loadData.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

void main() {
  runApp(const MyApp());
}
//apiyi calistirmak icinn metod yazmamiz lazim
Future<LoadData> apiCall() async {
  String urlString = "http://localhost:3000/db";
  Uri uri = Uri.parse(urlString);
  final response = await http.get(uri);
  if(response == 200){
    return LoadData.fromJson(json.decode(response.body));
  } else{
    throw Exception("Bir hata olutu");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Program API',
      theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Program API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: FutureBuilder<LoadData>(
      future: apiCall(),
      builder: (context, snapshot){
        //data null ise
        if(snapshot.hasData){ //bos degilse dedik
          return Container(
            child: Center(
              child: Text(
                "gun : ${snapshot.data?.gun} \n + sabah : ${snapshot.data?.sabah} \n + ogle : ${snapshot.data?.ogle} \n + araogun : ${snapshot.data?.araogun} \n + aksam : ${snapshot.data?.aksam}"
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    )
    );
  }
}
