import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wlg/joinQ.dart';
class collectionOfDart extends StatefulWidget {
  const collectionOfDart({super.key});

  @override
  State<collectionOfDart> createState() => _collectionOfDartState();
}

class _collectionOfDartState extends State<collectionOfDart> {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  List<DocumentSnapshot> data = [];
  void getData()async{
    QuerySnapshot qs = await firebase.collection('States').get();
    setState(() {
      data = qs.docs;
      print(data);
    });
  }
  void deleteData(int index)async{
    QuerySnapshot qs = await firebase.collection('States').get();
    data = qs.docs;
    setState(() {
      data[index].reference.delete();
      data = qs.docs;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      data.isEmpty
          ? Center(child: CircularProgressIndicator())
          :
                ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {

                  return Container(width: double.infinity,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width:50,
                            child: Icon(Icons.person_outline)),
                        Container(width: 240,
                          //color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index]['email'],style: TextStyle(color: Colors.blue[500],fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(data[index]['State'],style: TextStyle(color: Colors.red[500],fontSize: 15),),
                            ],
                          ),
                        ),
                        Container(width: 100,
                          //  color: Colors.cyan,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(onTap: (){
                                //  DatabaseHelper.instance.updateUser(index, _emailText.text,_passwordText.text);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                   JoinQ(index: index, email:data[index]['email'], password:data[index]['password'], title: 'Update Data IN FireBase', title2: 'Upload')
                                ));
                                Fluttertoast.showToast(msg: 'Update Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                //print(db);
                              }
                                  ,child: Icon(Icons.edit_sharp,)),
                              SizedBox(width:20,),
                              InkWell(onTap: (){
                                print(index);
                                deleteData(index) ;
                                setState(() {
                                  data;
                                  //  db.length;
                                  //   DatabaseHelper.instance.deleteUser(index);
                                  Fluttertoast.showToast(msg: 'Delete Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                  //   print(db);
                                  // getDataAll();
                                });
                              },child: Icon(Icons.delete,color: Colors.redAccent,)),
                            ],
                          ),)
                      ],
                    ),
                  );
                }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  JoinQ(index: -5, email:'', password:'', title: 'Add Data IN FireBase', title2: 'Upload')));
            },child: Icon(Icons.add),backgroundColor: Colors.blue[200],),
          ],
        ),
      ),
    );

  }
}
