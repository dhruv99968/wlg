import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wlg/about.dart';
import 'package:wlg/contactus.dart';
import 'package:wlg/home.dart';
class GridViews extends StatefulWidget {
  const GridViews({super.key});

  @override
  State<GridViews> createState() => _GridViewsState();
}

class _GridViewsState extends State<GridViews> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];

  int? current ;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
          body:  SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: [
                  //gridview.builder
                  SizedBox(height: 5,),
                  Container(color: Colors.white60,width: double.infinity,alignment: Alignment.center,child: Text('GridView Builder',)),
                  Container(
                    width: double.infinity,
                      height: 200,
                      color: Colors.white60,
                      padding: EdgeInsets.all(20.0),
                      child:
                      //          Text('GridView Builder'),

                            GridView.builder(
                              itemCount: images.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               //mainAxisExtent: 2,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 15.0,
                                  mainAxisSpacing: 20.0

                              ),
                              itemBuilder: (BuildContext context, int index){
                                return
                                        Tooltip(message: 'index :'+index.toString(),
                                          child: InkWell(
                                             child:  Container(
                                               width: double.infinity,
                                               height: double.infinity,
                                               child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                      Image.network(images[index],width: 90,height: 90,),
                                                  //  SizedBox(height: 10,),

                                                    Text(index.toString(),style: TextStyle(fontSize: 10),),

                                                  ],
                                                ),
                                             )

                                              ,onTap: (){
                                            print('Logcat: tap on :'+index.toString());
                                            Fluttertoast.showToast(msg: 'Tap on :'+index.toString() ,gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                          },
                                          ),

                                );
                              },

                            ),


                      ),

                  //gridview.count --->it dont have any index
                  SizedBox(height: 5,),
                  Container(width: double.infinity,child: Text('GridView Count'),color: Colors.white70,alignment: Alignment.center,),
                  Container(width: double.infinity,height: 200,color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(crossAxisCount: 4,mainAxisSpacing: 10,crossAxisSpacing: 10,
                      children: <Widget>[
                        InkWell(onTap:(){

                      },child: Card(
                          elevation: 5,
                          child: Icon(Icons.account_circle,),)),
                        InkWell(onTap: (){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle_outlined))),

                        InkWell(onTap:(){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle,),)),
                        InkWell(onTap: (){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle_outlined),)),
                        InkWell(onTap:(){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle,),)),
                        InkWell(onTap: (){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle_outlined),)),
                        InkWell(onTap:(){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle,),)),
                        InkWell(onTap: (){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle_outlined))),
                        InkWell(onTap:(){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle,))),
                        InkWell(onTap: (){

                        },child: Card(elevation: 5,child: Icon(Icons.account_circle_outlined))),

                      ],

                    ),
                  )),

                  //gridview.custom
                  SizedBox(height: 5,),
                  Container(width: double.infinity,child: Text('GridView Custom'),alignment: Alignment.center,),
                  Container(width: double.infinity,height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.custom(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 items per row
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              setState(() {
                              //  bgcolor[index] = Colors.pink[100];
                                current = index;
                              });

                            },
                            child: Container(
                              color:  current == index ? Colors.blue[100]:
                              Colors.primaries[index % Colors.primaries.length] ,
                              child: Center(child: Text('Item $index')),

                            ),
                          );
                        },
                        childCount: 50, // Total number of items
                      ),
                    ),
                  )
                  ),

                  //GridView extent where we are using children array where we dont have any index
                  //we can also add like list for index and we are place at array
                  SizedBox(height: 5,),
                  Container(width: double.infinity, color: Colors.pink[100],child: Text('GridView extent where we are using children array'),alignment: Alignment.center,),
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.pink[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.extent(maxCrossAxisExtent: 100,children: [
                        Card(elevation:5,child: Center(child: Text('hello',)),),
                        Card(elevation:5,child: Center(child: Text('hey',)),),
                        Card(elevation:5,child: Center(child: Text('hello',)),),
                        Card(elevation:5,child: Center(child: Text('hii',)),),
                        Card(elevation:5,child: Center(child: Text('hey',)),),
                        Card(elevation:5,child: Center(child: Text('hello',)),),
                        Card(elevation:5,child: Center(child: Text('hii',)),),
                        Card(elevation:5,child: Center(child: Text('hey',)),),
                        Card(elevation:5,child: Center(child: Text('hello',)),),
                        Card(elevation:5,child: Center(child: Text('hii',)),),
                      ],),
                    ),
                  ),

                ],
              ),
          ),
          ),



    );
  }
}
