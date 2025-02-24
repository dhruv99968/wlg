import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetInTable extends StatefulWidget {
  const GetInTable({super.key});

  @override
  State<GetInTable> createState() => _GetInTableState();
}

class _GetInTableState extends State<GetInTable> {
  List<TableRow> _row = [];
  String _email ='';
  String _password ='';
  int indexCounter = 0;
  TextEditingController _emailText = TextEditingController();
  TextEditingController _passwordText =TextEditingController();
  TextEditingController _removeText =TextEditingController();

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
    CircularProgressIndicator();
    _getOnApi();
  }


  void addText(String sEmail,String sPassword) {
    if(sEmail.isNotEmpty && sPassword.isNotEmpty ){
      setState(() {
        _row.add(TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10),
            child: Column(children: [
              Text(sEmail)
            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10),
            child: Column(children: [
              Text(sPassword)
            ],),
          ),
        ]));
      });
      //   print(_emailText.text+'..if else..'+_passwordText.text);
    }
    print(_emailText.text+'addText ..'+_passwordText.text);
  }
  List<dynamic> fetchedData = [];
  Future<void> _getOnApi()async{
    print("getonapi");
    final String url = 'https://retoolapi.dev/Eepea0/data';
    final response = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },);
    if (response.statusCode == 200) {
      setState(() {
        fetchedData = json.decode(response.body); // Parsing JSON response
      });
      print("succes data");
    } else {
      throw Exception('Failed to load data');
    }
    setState(() {
      fetchedData;
      int indexs = 0;
      print('hello its emails');
      for(indexs; indexs < fetchedData.length; indexs++){
        print("Email : "+fetchedData[indexs]['email'].toString());
        print("Password : "+fetchedData[indexs]['password'].toString());
        addText(fetchedData[indexs]['email'].toString(), fetchedData[indexs]['password'].toString());
      }});
  }
  Future<void>_apiUpdate(String email,String password)async {
    final String url ='https://reqres.in/api/users/2';
    final respond = await http.put(Uri.parse(url),
        headers: {'content-Type':'application/josn'},
        body: jsonEncode({'email':email,'password':password})
    );
    if(respond.statusCode ==200){
      print("success....update..."+respond.body);
      Fluttertoast.showToast(msg: 'updating email.');
      setState(() {
        addText(email, password);
      });

    }
    else{
      print('error in update..');
    }
  }
  Future<void> deleteKeyAtIndex(int index) async {
    final String url = 'https://reqres.in/api/users/';
    final respond = await http.delete(Uri.parse(url+'$index'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },);
    if(respond.statusCode == 204){
      print('delete success...'+respond.body);
      Fluttertoast.showToast(msg: 'Delete At index 2');
    }else{
      print('error in delete...from api so');
      print('delete from sharedprefrence...');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API - Get/Upadate/Delete/')),
      body: Padding(
      padding: const EdgeInsets.all(8.0),
      child:  SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Get API In Table',textAlign: TextAlign.center,),
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      ..._row,
                      TableRow(children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                              child: TextField(
                                decoration: InputDecoration(
                                  //  border: OutlineInputBorder(),

                                    hintText: 'Email Id'
                                ),
                                controller: _emailText,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                              child: TextField(
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                    hintText: 'Password'
                                ),
                                controller: _passwordText,
                              ),
                            )
                          ],
                        )
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Update In API',textAlign: TextAlign.center,),
                  ),
                  TextButton(onPressed: (){
                    //  if(_emailText.text.isNotEmpty && _passwordText.text.isNotEmpty){
                    //  addText(_emailText.text,_passwordText.text);
                    setState(() {
                      _emailText.text;
                      _passwordText.text;
                      if(_emailText.text != _passwordText.text){
                        setState(() {
                        //  _savedata(_emailText.text, _passwordText.text);
                        //  _getmassage();

                          _apiUpdate(_emailText.text.toString(), _passwordText.text.toString());
                        });
                        print(_row.length);
                      }else if(_emailText.text.isEmpty && _passwordText.text.isEmpty ){
                        Fluttertoast.showToast(msg: 'Please Enter Email And Password',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                      }
                      else{
                        Fluttertoast.showToast(msg: 'Change Email Or Paasword',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                      }
                      _emailText.clear();
                      _passwordText.clear();
                    });
                    print(_emailText.text+'...ontap ..'+_passwordText.text);
                  }
                      , child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.bounceIn,  // Apply a bouncing effect
                          width: 40.0 ,
                          // color: Colors.black,
                          height: 20.0 ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          alignment: Alignment.center

                          ,child: Text('Update data'))),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Index')
                    ),
                    controller: _removeText,
                  ),
                ),
                TextButton(onPressed: (){
                  int index = int.parse(_removeText.text);
                  setState(() {
                    //_row.reversed;
                    if(index == 2){
                      //  print(_row.elementAt(index));
                      // _row.removeAt(index);
                      deleteKeyAtIndex(index);
                    }else{
                      Fluttertoast.showToast(msg: 'Enter Valid Index.. Enter -> 2 ',
                          gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                    }
                  });

                },child: Text('Delet')),
                SizedBox(height: 100,)
              ],

            ),

          ],

        ),
      ),

    ),);
  }
}
