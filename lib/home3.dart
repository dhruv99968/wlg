import 'package:flutter/material.dart';

import 'contactus.dart';
import 'gridview.dart';
class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(children: [
        GridViews()  ,
        Contactus()
      ]),
    );
  }
}
