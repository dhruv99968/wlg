import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wlg/gridview.dart';
import 'package:wlg/home.dart';

import 'lists.dart';
class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  final List<String> imageUrls = [
    'https://via.placeholder.com/400x200/FF0000/FFFFFF?text=Image+1',
    'https://via.placeholder.com/400x200/00FF00/FFFFFF?text=Image+2',
    'https://via.placeholder.com/400x200/0000FF/FFFFFF?text=Image+3',
    'https://via.placeholder.com/400x200/FFFF00/FFFFFF?text=Image+4',
    'https://via.placeholder.com/350x150'
  ];
  bool _switch = false;
  String _selectedGender = '';
  Color? _active ;
  String val = '';
   double? _slidervalue ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('Contact Us'),),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column
              (
              children: [
                Container(color: Colors.purple[50],
                  width: double.infinity,
                  height: 200,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Swiper(
                      itemCount: imageUrls.length,
                      itemBuilder: (BuildContext context,int index){
                        return InkWell(onTap:(){
                          index = index +1;

                          Fluttertoast.showToast(msg: index.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                        },
                            child: kIsWeb ? Image.network(imageUrls[index],fit: BoxFit.cover,) : Image.asset("assets/images/Ima.png"));
                      },
                      autoplay: true,
                      // autoplayDelay: 1,

                      viewportFraction: 0.8,
                      scale: 0.9,

                      //  itemWidth : 300.0,
                      //itemHeight: 400.0,
                      //layout: SwiperLayout.TINDER,

                      //  layout: SwiperLayout.STACK,

                      pagination: SwiperPagination(),
                      control: SwiperControl(),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Switch(value:_switch,
                              activeColor: _active,
                              inactiveThumbColor: _active,
                              //activeTrackColor: Colors.purple,
                              //inactiveTrackColor: _active,
                              onChanged: (value){

                                if(value == true){
                                  setState(() {
                                    _switch = true;
                                    _active = Colors.blue;
                                    val = value.toString();
                                  });
                                  Fluttertoast.showToast(msg: value.toString(),toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);

                                }
                                else{
                                  setState(() {
                                    _switch = false;
                                    _active = Colors.purple;
                                    val = value.toString();
                                  });
                                  Fluttertoast.showToast(msg: value.toString(),toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);

                                }
                              }
                          ),
                        ),
                      SizedBox(width: 0.5,),
                        Text(val,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)


                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,)
                ,Container
                (
                  width: double.infinity,
                  height: 50,

                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:<Widget> [
                            Radio<String>(
                              value: 'Male',
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                              activeColor: Colors.blue, // Custom active color
                            ),
                            Text('Male'),
                            Radio(value: 'Female', groupValue:_selectedGender, activeColor: Colors.blue,onChanged: (value){
                              setState(() {
                                _selectedGender = value!;
                              });
                            }),
                            Text('Female'),
                            Radio(value: 'Other', activeColor: Colors.blue,groupValue: _selectedGender, onChanged: (value){
                              setState(() {
                                _selectedGender = value!;
                              });
                            }),
                            Text('Other'),

                          ],),
                        ),
                      //   SizedBox(width: 20,),
                         Row(mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text(_selectedGender,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                           ],
                         ),
                        SizedBox(width: 5,)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      Slider(
                          activeColor: Colors.orange,
                          min:0,max:100,value: _slidervalue ?? 00,
                        //  label: _slidervalue.toString(),
                          inactiveColor: Colors.amberAccent,
                          onChanged:( value){
                            setState(() {
                              _slidervalue = value;

                            });
                            Fluttertoast.showToast(msg: _slidervalue.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);

                      }),
                      //Text(_slidervalue!.round().toString().)
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: double.infinity,
                  height: 150,
                  child:  ListView.builder(
                    itemCount: imageUrls.length,
                      itemBuilder: (context, index){
                      return ListTile(
                        iconColor: Colors.greenAccent,
                        title: Text('title : $index'),subtitle: Text('subtitile'),
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Lists()));
                      },
                      );

                      }
                     ),)
                ,


              ],
            ),
          ),
        ));
  }
}

