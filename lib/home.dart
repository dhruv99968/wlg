import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wlg/about.dart';
import 'package:wlg/collectionofdart.dart';
import 'package:wlg/contactus.dart';
import 'package:wlg/fireBase.dart';
import 'package:wlg/getInTable.dart';
import 'package:wlg/gridview.dart';
import 'package:wlg/joinQ.dart';
import 'package:wlg/main.dart';
import 'package:wlg/sqlite.dart';

import 'home2.dart';
import 'home3.dart';
import 'lists.dart';

class Home extends StatefulWidget {
  final String email;
  final String password;

  // Constructor without const (since we are passing dynamic data)
  Home({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _screen = [Home2(), sqlITE(), fireBase(),collectionOfDart(), Home3()];
  int _selectedindex = 0;
  final PageController _pageController = PageController();
  Widget title(int index) {
    if (index == 0) {
      return Text("SharedPreferences");
    } else if (index == 1) {
      return Text("SQLite");
    } else if (index == 2) {
      return Text("FireBase");
    } else if (index == 3) {
      return Text("Collection Firebase");
    } else {
      return Text("Widget");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: title(_selectedindex),
          bottom: _selectedindex == 4
              ? TabBar(tabs: const [
                  Tab(
                    icon: Icon(Icons.grid_view_outlined),
                    text: 'GridView',
                  ),
                  Tab(
                    icon: Icon(Icons.contact_page_outlined),
                    text: 'Contact us',
                  )
                ])
              : null,
        //  actions: _selectedindex == 3 ? PopupMenuButton(itemBuilder: (BuildContext context) => []) : null
        ),
        body: _screen[_selectedindex],
        //Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.sd_storage_outlined,
                ),backgroundColor: Colors.white,
                label: 'SharedPreferences'),
            BottomNavigationBarItem(
                icon: Icon(Icons.storage_outlined),backgroundColor: Colors.white, label: 'SQLite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_outlined
                ),backgroundColor: Colors.white,label: 'FireBase'),
            BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark
                ),backgroundColor: Colors.white,
                label: 'Collection Firebase'),
            BottomNavigationBarItem(
                icon: Icon(Icons.widgets_outlined
                ),backgroundColor: Colors.white,

                label: 'Widget')
          ],
         // backgroundColor: Colors.pink,
          selectedFontSize: 15,
          selectedItemColor: Colors.blue[300],
          //showSelectedLabels: true,
          unselectedFontSize: 10,
          unselectedItemColor: Colors.green, // elevation: 5,
       //   backgroundColor: Colors.cyan,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _selectedindex = index;
            });
          },
          currentIndex: _selectedindex,
        ),
        // endDrawer for right side drawer
        drawer: Drawer(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  widget.email,
                  style: TextStyle(color: Colors.blue[50]),
                ),
                accountEmail: Text(
                  widget.password,
                  style: TextStyle(color: Colors.blue[100]),
                ),
                // otherAccountsPictures: [Icon(Icons.person_outline,size: 50,color: Colors.blue[100],)],
                currentAccountPicture: Icon(
                  Icons.account_circle_outlined,
                  size: 50,
                  color: Colors.blue[100],
                ),
                //  otherAccountsPicturesSize: Size.square(5.2),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                email: widget.email,
                                password: widget.password,
                              )));
                },
              ),
              ListTile(
                title: Text('Get Api In ListView'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Lists()));
                },
              ),
              ListTile(
                title: Text('Get Api In Table'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetInTable()));
                },
              ),
              ListTile(
                title: Text('Contact us'),
                onTap: () {
                  //   Scaffold.of(context).showSnackBar(snackbar,5);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Contactus()));
                },
              ),
              ListTile(
                title: Text(
                  'About',
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
              ),
              ListTile(
                title: Text(
                  'Logout',
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
