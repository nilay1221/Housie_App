import 'package:flutter/material.dart';
import 'package:housie_bloc/widgets/widgets.dart';

class EndDialog extends StatelessWidget {

  final String title;
  final String text;
  EndDialog(
    {this.text,this.title}
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "$title",
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.w700),
      ),
      content: Container(
        width: 100.0,
//        height: 70.0,
        child: Text(
          "$text",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15.0,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Yes"),
          onPressed: () async {
            Navigator.pop(context,true);
          },
        ),
        FlatButton(
          child: Text("No"),
          onPressed: () {
            Navigator.pop(context,false);
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
