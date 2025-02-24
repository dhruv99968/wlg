import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wlg/Sqlite/databasehelper.dart';
import 'package:wlg/Sqlite/databasehelper.dart';
import 'package:wlg/addupdate.dart';

import 'package:wlg/modelClass/user.dart';

import 'Sqlite/databasehelper.dart';
class sqlITE extends StatefulWidget {
  const sqlITE({super.key});

  @override
  State<sqlITE> createState() => _sqlITEState();
}

class _sqlITEState extends State<sqlITE> {
  List<TableRow> _row = [];
  TextEditingController _emailText = TextEditingController();
  TextEditingController _passwordText =TextEditingController();
  TextEditingController _removeText =TextEditingController();
  List<Map<String, dynamic>> db = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _row.add(TableRow(children: [
      Column(
        children: [
          Text('Email Id'),
        ],
      ),
      Column(
        children: [
          Text('Password'),
        ],
      )
    ]),);
    //after first the row
    getDataAll();
  }

  Future<void>getDataAll() async {
    db = await DatabaseHelper.instance.getData() ;
    // User user = User.fromMap(DatabaseHelper.instance.getData() as Map<String, dynamic>);
    // print(user);
    //  DatabaseHelper.instance.getData();

   /* for(int i = 0 ; i <= db.length ; i++ ){
     // print(db[i]['email']);
      setState(() {
       // addText(db[i]['email'],db[i]['password']);
      });
    }*/
    setState(() {
      db;
    });
    Fluttertoast.showToast(msg: 'Get Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
    print(db);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('ListView with API')),
      body: db.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: db.length,
        itemBuilder: (context, index) {
          return
           /* leading: Icon(Icons.person_outline),
            title: Text(db[index]['email'],style: TextStyle(backgroundColor: Colors.cyan,color: Colors.blue[500],fontWeight: FontWeight.bold,fontSize: 20),),
            subtitle: Text(db[index]['password'],style: TextStyle(backgroundColor: Colors.red,color: Colors.red[500],fontSize: 15),),
          trailing:
          */
           Container(width: double.infinity,
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
                          Text(db[index]['email'],style: TextStyle(color: Colors.blue[500],fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(db[index]['password'],style: TextStyle(color: Colors.red[500],fontSize: 15),),
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
                          Fluttertoast.showToast(msg: 'Update Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=>addUpdate(index: index, index2: 0, email:db[index]['email'], password: db[index]['password'],title: 'Update Data IN SQLite',title2: 'Update',)
                          ));
                              print(db);
                        }
                            ,child: Icon(Icons.edit_sharp,)),
                        SizedBox(width:20,),
                        InkWell(onTap: (){
                          print(index);
                          setState(() {
                            //  db.length;
                              DatabaseHelper.instance.deleteUser(index);
                              Fluttertoast.showToast(msg: 'Delete Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                              print(db);
                              getDataAll();
                          });
                        },child: Icon(Icons.delete,color: Colors.redAccent,)),
                      ],
                    ),)


                  ],
                ),
           );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
       Navigator.push(context,
           MaterialPageRoute(
               builder: (context)=>
                   addUpdate(index:-1, index2: -1,email:'', password:'', title: 'Add Data IN SQLite',title2: 'Add',)
           ));
      },child: Icon(Icons.add,),backgroundColor: Colors.blue[200],),
    );

  }
}
