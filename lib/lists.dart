import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  List<dynamic> items = [];

  Future<void> fetchData() async {
   final String url ="https://retoolapi.dev/Eepea0/data";
   final response = await http.get(Uri.parse(url),
     headers: {
     'Content-Type': 'application/json',
   },

   );
    if (response.statusCode == 200) {
      setState(() {
        items = json.decode(response.body); // Parsing JSON response
      });
    } else {
      throw Exception('Failed to load data');
    }

  }
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView with API')),
      body: items.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]['email'].toString(),style: TextStyle(color: Colors.blue[500],fontWeight: FontWeight.bold,fontSize: 20),),
            subtitle: Text(items[index]['password'].toString(),style: TextStyle(color: Colors.red[500],fontSize: 15),),


          );
        },
      ),
    );
  }
}
