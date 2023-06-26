// import 'dart:convert';

// import 'package:fake_backend/model/loadData.dart';
// import 'package:flutter/material.dart';
// import "package:http/http.dart" as http;

// void main() {
//   runApp(const MyApp());
// }
// //apiyi calistirmak icinn metod yazmamiz lazim
// Future<LoadData> apiCall() async {
//   String urlString = "http://localhost:3000/db";
//   Uri uri = Uri.parse(urlString);
//   final response = await http.get(uri);
//   if(response.statusCode == 200){
//     return LoadData.fromJson(json.decode(response.body));
//   } else{
//     print('Hata Kodu: ${response.statusCode}');
//     throw Exception("Bir hata oluştu");
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Program API',
//       theme: ThemeData(
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MyHomePage(title: 'Program API'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {


//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//     body: FutureBuilder<LoadData>(
//       future: apiCall(),
//       builder: (context, snapshot){
//         //data null ise
//         if(snapshot.hasData){ //bos degilse dedik
//           return Container(
//             child: Center(
//               child: Text(
//                 "gun : ${snapshot.data?.gun} \n  sabah : ${snapshot.data?.sabah} \n  ogle : ${snapshot.data?.ogle} \n  araogun : ${snapshot.data?.araogun} \n  aksam : ${snapshot.data?.aksam}"
//               ),
//             ),
//           );
//         } else {
//           return Center(child: CircularProgressIndicator(),);
//         }
//       },
//     )
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/loadData.dart';

void main() {
  runApp(const MyApp());
}

Future<LoadData> apiCall() async {
  String urlString = "http://localhost:3000/db";
  Uri uri = Uri.parse(urlString);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return LoadData.fromJson(json.decode(response.body));
  } else {
    print('Hata Kodu: ${response.statusCode}');
    throw Exception("Bir hata oluştu");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<LoadData> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LoadData>(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.program1.length ?? 0,
              itemBuilder: (context, index) {
                var item = snapshot.data?.program1[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gun: ${item?.gun}"),
                      Text("Sabah: ${item?.sabah}"),
                      Text("Ogle: ${item?.ogle}"),
                      Text("Araogun: ${item?.araogun}"),
                      Text("Aksam: ${item?.aksam}"),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Hata: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
