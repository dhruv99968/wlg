import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wlg/Sqlite/databasehelper.dart';
import 'package:wlg/modelClass/user.dart';
class addUpdate extends StatefulWidget {

  final String password;
  final String email;
  final int index;
  final int index2;
  final String title;
  final String title2;
  addUpdate({Key? key,
  required this.index,
    required this.index2,
  required this.email,
  required this.password,
  required this.title,
  required this.title2}) : super(key: key);
  @override
  State<addUpdate> createState() => _addUpdateState();
}

class _addUpdateState extends State<addUpdate> {
  TextEditingController _password = TextEditingController();
  TextEditingController _email= TextEditingController();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email.text = widget.email;
    _password.text = widget.password;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.title),),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(widget.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top:10 ,bottom:10 ,right:20 ,left:20 ),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email')
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10 ,bottom:10 ,right:20 ,left:20 ),
              child: TextFormField(
                controller: _password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password')
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(onPressed: () async {
                List<Map<String, dynamic>> db = await DatabaseHelper.instance.getData() ;
                if(widget.index == -1){
                  setState(() {
                    _email.text;
                    _password.text;
                    if(_email.text != _password.text){
                      User user = User(email:_email.text.toString(), password: _password.text.toString());
                      setState(() {
                        ///add data
                        DatabaseHelper.instance.insertUser(user);
                        Fluttertoast.showToast(msg: 'Add Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                        print(db);
                      });
                      //  print(_row.length);
                    }else if(_email.text.isEmpty && _password.text.isEmpty ){
                      Fluttertoast.showToast(msg: 'Please Enter Email And Password',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                    }
                    else{
                      Fluttertoast.showToast(msg: 'Change Email Or Paasword',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                    }
                    _email.clear();
                    _password.clear();
                  });

                  print(_email.text+'...ontap ..'+_password.text);
                }/*else if(widget.index == -2){
                  setState(() {
                    _email.text;
                    _password.text;
                    if(_email.text != _password.text){
                      setState(() {
                        ///add data
                       // String id = firebase.collection('UserInfo').id;
                       firebase.collection('UserInfo').add({'email':_email.text,'password':_password.text});
                        Fluttertoast.showToast(msg: 'Add Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                      });
                      //  print(_row.length);
                    }else if(_email.text.isEmpty && _password.text.isEmpty ){
                      Fluttertoast.showToast(msg: 'Please Enter Email And Password',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                    }
                    else{
                      Fluttertoast.showToast(msg: 'Change Email Or Paasword',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                    }
                    _email.clear();
                    _password.clear();
                  });

                  print(_email.text+'...ontap ..'+_password.text);
              }else if(widget.index2 == -3){
                 List<DocumentSnapshot> data =[];
                    QuerySnapshot qs = await firebase.collection('UserInfo').get();
                    data = qs.docs;
                    User user = User(email:_email.text, password: _password.text);
                    setState(() {
                      data[widget.index].reference.update(user.toMap());
                      data = qs.docs;
                    });
                }*/
                else{
                  DatabaseHelper.instance.updateUser(widget.index, _email.text,_password.text);
                  print(db);
                }

              }, child:Text(widget.title2)),
            )
          ],
        ),
      ),
    );
  }
}
