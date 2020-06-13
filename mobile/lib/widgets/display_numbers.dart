import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  Map data;



  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: ()
            {
              Navigator.pop(context);
            },
          ),
          title: Text("Numbers Called",style: TextStyle(color: Colors.black,fontFamily: 'Oswald',fontWeight: FontWeight.w700),),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 5.0),
          child: Column(
            children: <Widget>[
              getNumbers(0),
              getNumbers(10),
              getNumbers(20),
              getNumbers(30),
              getNumbers(40),
              getNumbers(50),
              getNumbers(60),
              getNumbers(70),
              getNumbers(80),
            ],
          ),
        ),
      );
  }



  bool check_number(var numbers,int number)
  {
    for(var each in numbers)
    {
      if(each == number){
        return true;
      }
    }
    return false;
  }

  Widget getNumbers(int range) {
    var numbers = this.data['numbers'];
    List<Widget> list = new List<Widget>();
    for (var i = range+1; i <= range+10; i++) {
      if (check_number(numbers, i) ) {
        list.add(
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              width: 36.0,
              height: 32.0,
//              color: Colors.red,
              margin: EdgeInsets.only(top: 10.0,left: 1.4,right:0.0),
              padding: EdgeInsets.all(5.0),
              child: Text("$i",

                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
        );
      }
      else {
        list.add(
            Container(
              width: 36.0,
              height: 30.0,
              margin: EdgeInsets.only(top: 10.0,left: 2.0,right: 0.0),
              child: Text("$i",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
        );
      }
    }
    return new Row(children: list);
  }
}
