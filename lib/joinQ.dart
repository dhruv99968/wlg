import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wlg/modelClass/user.dart';
class JoinQ extends StatefulWidget {
  final String password;
  final String email;
  final int index;

  final String title;
  final String title2;
 // final String sName;
  JoinQ({Key? key,
    required this.index,
    required this.email,
    required this.password,
    required this.title,
    required this.title2, //required this.sName
  }) : super(key: key);
  @override
  State<JoinQ> createState() => _JoinQState();
}

class _JoinQState extends State<JoinQ> {
  TextEditingController _password = TextEditingController();
  TextEditingController _email= TextEditingController();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  String? Dropvalue  ;
  final List<String> items = [
    'Andhra Pradesh (Amaravati)',
    'Arunachal Pradesh (Itanagar)',
    'Assam (Dispur)',
    'Bihar (Patna)',
    'Chhattisgarh (Raipur)',
    'Goa (Panaji)',
    'Gujarat (Gandhinagar)',
    'Haryana (Chandigarh)',
    'Himachal Pradesh (Shimla)',
    'Jharkhand (Ranchi)',
    'Karnataka (Bangalore)',
    'Kerala (Thiruvananthapuram)',
    'Madhya Pradesh (Bhopal)',
    'Maharashtra (Mumbai)',
    'Manipur (Imphal)',
    'Meghalaya (Shillong)',
    'Mizoram (Aizawl)',
    'Nagaland (Kohima)',
    'Odisha (Bhubaneswar)',
    'Punjab (Chandigarh)',
    'Rajasthan (Jaipur)',
    'Sikkim (Gangtok)',
    'Tamil Nadu (Chennai)',
    'Telangana (Hyderabad)',
    'Tripura (Agartala)',
    'Uttar Pradesh (Lucknow)',
    'Uttarakhand (Dehradun)',
    'West Bengal (Kolkata)'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email.text = widget.email;
    _password.text = widget.password;
   // Dropvalue = widget.sName;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.title),),
      body: Container(
        //width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           /* Container(width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                )),*/
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

       Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                        hint: Text('State'),
                        itemHeight: 50,
                        menuWidth: 100,
                        menuMaxHeight: 300,
                        elevation: 5,
                        dropdownColor: Colors.blue[50],
                        value:Dropvalue,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((item) {
                          return DropdownMenuItem(
                            alignment: Alignment.center,
                            value: item,
                            child: Center(child: Text(item)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                         print('n -$newValue');
                          setState(() {
                            Dropvalue = newValue!;
                            print('n add -$Dropvalue');
                          });
                    }),
              ),
            ],
          ),
        ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(onPressed: ()  {
                  setState(() async {
                    _email.text;
                    _password.text;
                    if(widget.index == -5){
                      if(_email.text != _password.text){
                          ///add data
                          // String id = firebase.collection('UserInfo').id;
                          if(Dropvalue == null){
                            Fluttertoast.showToast(msg: 'Select The State',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                          }
                          else{
                              firebase.collection('UserInfo').doc(_email.text.toString()).set({'email':_email.text,'password':_password.text,'State':Dropvalue.toString()});
                              firebase.collection('States').doc(Dropvalue.toString()).set({'email':_email.text,'password':_password.text,'State':Dropvalue.toString()});
                              Fluttertoast.showToast(msg: 'Add Success...',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                              _email.clear();
                              _password.clear();
                              Dropvalue = null;
                          }

                        //  print(_row.length);
                      }else if(_email.text.isEmpty && _password.text.isEmpty ){
                        Fluttertoast.showToast(msg: 'Please Enter Email And Password',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                      }
                      else{
                        Fluttertoast.showToast(msg: 'Change Email Or Paasword',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                      }

                    }else{
                      List<DocumentSnapshot> data =[];
                      QuerySnapshot qs = await firebase.collection('States').get();
                      data = qs.docs;
                   //   User user = User(email:_email.text, password: _password.text);
                      setState(() {
                       data[widget.index].reference.update({'email':_email.text,'password': _password.text,"State":Dropvalue});
                        data = qs.docs;
                      });
                    }

                  });

                  print(_email.text+'...ontap ..'+_password.text);
                }
              , child:Text(widget.title2)),
            )
          ],
        ),
      ),
    );
  }
}
