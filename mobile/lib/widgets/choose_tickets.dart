import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:housie_bloc/services/get_tickets.dart';



class ChooseTickets extends StatefulWidget {
  @override
  _ChooseTicketsState createState() => _ChooseTicketsState();
}

class _ChooseTicketsState extends State<ChooseTickets> {


  var numberOfTickets = new List<int>.generate(25, (i) => i + 1);
  var _currentValue = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generator",style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Choose Number of Tickets:"),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _currentValue,
                items: numberOfTickets.map<DropdownMenuItem<int>>((int number){
                  return DropdownMenuItem<int>(
                    value: number,
                    child: Text(number.toString(),
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (int _newValue){
                  setState(() {
                    _currentValue = _newValue;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 60.0,
                width: 250.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.purple,
                  child: Text(
                    "Generate Tickets",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async{
                        try{
                          GetTickets ticket = GetTickets(numberOfTickets: this._currentValue);
//                          await tihometestcket.saveTickets();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return loadingDialog();
                              });
                            await ticket.saveTickets();
                              Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return generatedDialog(ticket.folderName);
                              });

                        }
                        catch(e,stacktrace){
                          print(e);
                          print(stacktrace.toString());
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return errorDialog(context);
                              });
                        }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget generatedDialog(String folderName){

    return AlertDialog(
      title: Text(
        "Tickets Generated"
      ),
      content: Container(
        width: 100.0,
        height: 60.0,
        child: Column(
          children: <Widget>[
            AutoSizeText(
                "Your tickets have been stored in HousieTicket/$folderName folder.",
                maxLines: 2,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    );




  }

Widget loadingDialog(){

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Container(
        width: 100.0,
        height: 60.0,
        child: Center(
          child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 20.0,
              ),
              Text("Please wait...")
            ],
          ),
        ),
      ),
    );

}

}

Widget errorDialog(BuildContext context) {

  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0)
    ),
    title: Text("Task Failed"),
    content: Container(
      width: 100.0,
      height: 60.0,
      child: Center(
        child: Row(
          children: <Widget>[
            Icon(Icons.highlight_off,
            color: Colors.red,
            size: 40.0,),
            SizedBox(
              width: 10.0,
            ),
            AutoSizeText(
              "Please try again later",
              maxLines: 2,
            )
          ],
        ),
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Text("OK"),
        onPressed: (){
        Navigator.pop(context);
        },
      )
    ],
  );

}