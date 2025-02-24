import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<TableRow> _row = [];
  String _email ='';
  String _password ='';
  int indexCounter = 0;
  TextEditingController _emailText = TextEditingController();
  TextEditingController _passwordText =TextEditingController();
  TextEditingController _removeText =TextEditingController();
  Future<void>_date() async{
    final data = await SharedPreferences.getInstance();
    setState(() {
      _email = (data.getString('email')??"dheuv");
      _password = (data.getString('password')??'heelo');

      _row.add(TableRow(children: [
        Column(children: [Text(_email.toString())],),
        Column(children: [Text(_password.toString())]),
      ]));
     // addText(_email,_password) ;
    });
  }
  Future<void> _savedata(String emails ,String passwords)async {
    final _data = await SharedPreferences.getInstance();
    final keys = _data.getKeys();
    int val;
    val = keys.length;
    Map<String, String> values = {'value1': emails, 'value2': passwords};
    // Convert Map to JSON String for storage
    String jsonString = jsonEncode(values);
    setState(() async {
      val++;
      print('new index :key$val');
      await _data.setString('key$val', jsonString);

      addText(emails, passwords);
      // getAllMapDataFromSharedPreferences();
    });

    //getAllMapDataFromSharedPreferences();
    // Save JSON String in SharedPreferences
    // await _data.setString('emails',emails);
    // await _data.setString('passwords', passwords);
    // setState(() {
    //   _storedEmail = (_data.getString('emails')??"");
    //   _storedPassword = (_data.getString('passwords')??'');
    // });

   // addText(_storedEmail.toString(),_storedPassword.toString());
  }

  Future<void> getAllMapDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys(); // Get all keys in SharedPreferences
  //  List<Map<String, String>> allMapData = [];
    setState(() {

    });
    for (var key in keys) {
      // Get the JSON String from SharedPreferences for each key
      String? jsonString = prefs.getString(key);
      if (jsonString != null) {

        try {
          // Attempt to decode the JSON string into a Map
          Map<String, String> values = Map<String, String>.from(jsonDecode(jsonString));
          print('Data retrieved for key "$key": $values');

        //  allMapData.add(values); // Add the map to the result list
          // Check if both 'value1' and 'value2' exist
          if (values.containsKey('value1') && values.containsKey('value2')) {
          /*  setState(() {
              _row.add(TableRow(children: [
                Column(children: [Text(values['value1']!)],),
                Column(children: [Text(values['value2']!)]),
              ]));

            });*/
            setState(() {
              addText(values['value1']!, values['value2']!);
            });

            // Add this map to the result list if both values exist
           // allMapData.add(values);
          } else {
            setState(() {

            });
            print('Key "$key" does not contain both "value1" and "value2".');
          }
        } catch (e) {
          setState(() {

          });
          // Handle non-JSON or invalid data
          print('Key "$key" does not contain valid map data: $e');
        }
      }
    }
 //   return allMapData;
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

  Future<void> deleteKeyAtIndex(int index) async {
   /* final String url = 'https://reqres.in/api/users/';
    final respond = await http.delete(Uri.parse(url+'$index'),
      headers: <String, String>{
      'Content-Type': 'application/json',
    },);
    if(respond.statusCode == 204){
      print('delete success...'+respond.body);
    }else{
      print('error in delete...from api so');
      print('delete from sharedprefrence...');
    }*/
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().toList();
      keys.reversed;
      // Get all keys in SharedPreferences and convert to list
      if (index <= keys.length && index >=2) {
        // Retrieve the key based on the index
        // Remove the key-value pair from SharedPreferences
        setState(() {
          String keyToDelete = keys[index];
          prefs.remove(keyToDelete);
          keys;
          print('Data deleted for key "$keyToDelete"');
        });
      } else {
        print('Invalid index');
      }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _row.add(TableRow(children: [
      Column(
        children: [
          Text("Email Id"),
        ],
      ),
      Column(
        children: [
          Text("Password"),
        ],
      )
    ]),);
    //after first the row
    CircularProgressIndicator();
    _date();
    getAllMapDataFromSharedPreferences();
    // _getOnApi();
    //_loadSharedPreferencesData();
  }

  String massage = 'SharedPreferences Data';
   static const platform = MethodChannel('com.example/massage');
  Future<void> _getmassage() async{
    String result ='' ;
    try{
      result = await platform.invokeMethod('getMassage');
      massage = result;
      print('result :$result and massage:$massage');
    }catch(e){
      result ='$e';
      massage = result;
      print('result :$result and massage:$massage');
    }
  }
//locale

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
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
                          child: Text(massage,textAlign: TextAlign.center,),
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
                                        label: Text(AppLocalizations.of(context)!.email_id)
                                     //   hintText: 'Email Id'
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
                                          label: Text(AppLocalizations.of(context)!.password)
                                         // hintText: 'Password'
                                      ),
                                      controller: _passwordText,
                                    ),
                                  )
                                ],
                              )
                            ]),
                          ],
                        ),
                        ElevatedButton(onPressed: (){
                          //  if(_emailText.text.isNotEmpty && _passwordText.text.isNotEmpty){
                          //  addText(_emailText.text,_passwordText.text);
                          setState(() {
                            _emailText.text;
                            _passwordText.text;
                            if(_emailText.text != _passwordText.text){

                              setState(() {
                                _savedata(_emailText.text, _passwordText.text);
                                _getmassage();
                              });
                              print(_row.length);
                            }else if(_emailText.text.isEmpty && _passwordText.text.isEmpty ){
                              Fluttertoast.showToast(msg: AppLocalizations.of(context)!.enter_email_pass,gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                            }
                            else{
                              Fluttertoast.showToast(msg: AppLocalizations.of(context)!.change_email_pass,gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                            }
                            _emailText.clear();
                            _passwordText.clear();
                          });
                          print(_emailText.text+'...ontap ..'+_passwordText.text);
                        }
                            , child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.bounceIn,  // Apply a bouncing effect
                                width: 200 ,
                                // color: Colors.black,
                                height: 20.0 ,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                alignment: Alignment.center
                                ,child: Text(AppLocalizations.of(context)!.add_d_sharedp))),

                      ],
                    ),
                  ),

                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.delete_d_sharedp,textAlign: TextAlign.center,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                          Container(
                            width: 200,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text(AppLocalizations.of(context)!.delete_index)
                              ),
                              controller: _removeText,
                            ),
                          ),
                      TextButton(onPressed: (){
                        int index = int.parse(_removeText.text);
                        setState(() {
                           //_row.reversed;
                          if(index >=2){
                            _row.removeAt(index);
                            deleteKeyAtIndex(index);
                            print('Delete Row : $_row.elementAt(index) ');
                          }else{
                            Fluttertoast.showToast(msg: AppLocalizations.of(context)!.delete_index_toast,
                            gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                          }
                        });

                      }, child: Text(AppLocalizations.of(context)!.delete_row)),
                    ],

                  ),

                ],

            ),
          ),

    ),);
  }

  }
