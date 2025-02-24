import 'dart:convert';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wlg/Sqlite/databasehelper.dart';
import 'package:wlg/fireBase.dart';


import 'package:wlg/home.dart';
import 'package:http/http.dart'as http;
import 'package:wlg/modelClass/user.dart';
import 'package:wlg/sqlite.dart';

import 'sqlite.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en', ''), // English
        Locale('hi', ''), // Spanish
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: 'Flutter Demo',
      theme: ThemeData(

        // This is the theme of your application.
        //

        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //

        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        appBarTheme: AppBarTheme(color: Colors.purple[100]),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool _checkvalue = false;

  Future<void> _savedata(String email ,String password)async {
    final _data = await SharedPreferences.getInstance();
    await _data.setString('email',email);
    await _data.setString('password', password);
  }
  Future<void>_postEmPa(String email,String password)async {
    final String url = 'https://reqres.in/api/users'; //

      final respond = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:jsonEncode({
            "name":email,
            "job":password
          })
      );
      if(respond.statusCode == 201){
        print('success........'+respond.body);
      }
      else{
        print("error");
      }
  }
  @override
  Widget build(BuildContext context) {
   // var _items = ['hello 1','hello 2','hello 3'];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        /// backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection:Axis.vertical,child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(Icons.insert_emoticon_outlined),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('text widget'),
                            ),
                          ]),

                        SizedBox(height: 10,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 10,),
                              TextButton(onPressed: (){
                                Fluttertoast.showToast(msg: 'on pressed');},
                                onLongPress: (){
                                Fluttertoast.showToast(msg: 'on long press');
                                }
                                 ,child: Text('Text button',style: TextStyle(color: Colors.black),)),
          
                              SizedBox(width: 10,),  BackButton(onPressed: (){},color: Colors.blue[100],),
          
                              SizedBox(width: 10,),  ElevatedButton(onPressed: (){  Fluttertoast.showToast(msg: 'on pressed');},
                                  onLongPress: (){
                                    Fluttertoast.showToast(msg: 'on long press');}, child: Text('Elevated Button',style: TextStyle(color: Colors.black),)),
          
                              SizedBox(width: 10,), OutlinedButton(onPressed: (){  Fluttertoast.showToast(msg: 'on pressed');},
                                  onLongPress: (){
                                    Fluttertoast.showToast(msg: 'on long press');}, child: Text('OutLine Button',style: TextStyle(color: Colors.black),)),
                              SizedBox(width: 10,),
                              FilledButton(onPressed: (){  Fluttertoast.showToast(msg: 'on pressed');},
                                  onLongPress: (){
                                    Fluttertoast.showToast(msg: 'on long press');}, child: Text('Filled Button')),
                              SizedBox(width: 10,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    CloseButton(onPressed: (){},color: Colors.blue[100],),
                                    Text('close button')
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FloatingActionButton(onPressed: (){},child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Floating Action Button',),
                                ),),
                              ),
                              SizedBox(width: 10,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.image,color: Colors.blue[100],),),
                                    Text('Icon Button')
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,), 
                              Column(
                                children: [
                                  PopupMenuButton(itemBuilder: (BuildContext context){
                                    return [PopupMenuItem(value: 'one',child: Text('one')),
                                      PopupMenuItem(value: 'two',child: Text('two')),
                                      PopupMenuItem(value: 'three',child: Text('three'))
                                    ];},
                                    onSelected:(String value){
                                    print(value);
                                    Fluttertoast.showToast(msg: value,gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG,);} ,),
                                Text('pop manu')
                                ],
                              ),
                              SizedBox(width: 10,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextButton(onPressed: (){
                                  showDialog(context: context, builder: (BuildContext context){
                                    return AlertDialog(title:Text('Alert Dialog '),icon: Icon(Icons.add_alert,color: Colors.blue[100],),actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text('ok',style: TextStyle(color: Colors.black),))],);
                                  });
                                }, child:Text('Show Alert dialog ',style: TextStyle(color: Colors.black),)),
                              ),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Stack(
                          children:<Widget>[Image.network("https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",width: 200,height: 200,)
                            ,Card(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                          ),color: Colors.blue[100],child: Image.asset('assets/images/download.jpeg',width: 100,height: 150,)),
                            Positioned(bottom: 10,right:10,child:  Container(child: ElevatedButton(onPressed: () {  }, child:Text('Text'),)))
                        ]),
                        SizedBox(height: 70,),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(child:Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email',
                                      icon: Icon(Icons.email),
                                      hintText: 'xyz@gmail.xom',

                                    ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _email,
                                  ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  maxLength: 6,
                                  decoration:InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      icon: Icon(Icons.password))
                                  ,obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: _pass,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Checkbox(value: _checkvalue, onChanged:(value){
                                if(value == true){
                                    setState(() {
                                        _checkvalue = true;
                                     });
                                  }
                                  else{
                                    setState(() {
                                      _checkvalue = false;
                                     });
                                  }


                              }),
                              SizedBox(height: 10,),
                              Hero(
                                tag: 'hero-page',
                              //  transitionOnUserGestures: true,
                                child: FilledButton(onPressed: (){
                                    setState(() {
                                      if(_email.text.isEmpty){
                                        print('Logcat: Please Enter the email');
                                        Fluttertoast.showToast(msg: 'Logcat: Please Enter the Email',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG,);
                                      }
                                      if(_pass.text.isEmpty){
                                        print('Logcat: Please Enter the password');
                                        Fluttertoast.showToast(msg: 'Please Enter the password',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG,);
                                      }
                                      if(_email.text.isNotEmpty && _pass.text.isNotEmpty && _checkvalue == true){
                                        final email = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                        if(email.hasMatch(_email.text) ) {
                                          print('Logcat: Your email is :' + _email.text);
                                          print('Logcat: Your password is :' + _pass.text);
                                          Fluttertoast.showToast(msg: 'login',
                                              gravity: ToastGravity.BOTTOM,
                                              toastLength: Toast.LENGTH_LONG);
                                          setState(() {
                                            Navigator.push(context,
                                          //      MaterialPageRoute(builder: (context)=>Home(email :_email.text,password : _pass.text))
                                                PageRouteBuilder(
                                                pageBuilder: (context, animation, secondaryAnimation) {
                                              return Home(email :_email.text,password : _pass.text);
                                            },
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            // Slide transition animation from left to right
                                            var begin = Offset(1.0, 0.0);  // Starting position off-screen to the right
                                            var end = Offset.zero;           // End position (on-screen)
                                            var curve = Curves.easeInBack;    // Smooth easing curve
                                            var tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));
                                            var offsetAnimation = animation.drive(tween);
                                            // Return a SlideTransition with the animation applied
                                            return SlideTransition(position: offsetAnimation, child: child);
                                            },
                                                  transitionDuration: Duration(milliseconds: 500 )
                                                ),
                                            );

                                            _savedata(_email.text,_pass.text);
                                            _postEmPa(_email.text.toString(),_pass.text.toString());
                                          });
                                        }
                                        else{
                                          print('Logcat: Enter valid email');
                                          Fluttertoast.showToast(msg: 'invalid email formate',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                        }
                                      }
                                      if(_checkvalue == false){
                                        setState(() {
                                          Fluttertoast.showToast(msg: 'Fill CheckBox',gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                          print(_checkvalue);
                                        });
                                      }
                                    });
                                  }, child: Text(AppLocalizations.of(context)!.login_user,),),
                                ),

                            ],
                            )),
                          ),
                        ),
          

                      ]
          
          
                  ),
        ),
      ),

    );
  }
}
