import 'package:flutter/material.dart';

class Winners extends StatelessWidget {

  final List<Map> winners_list;

  Winners({this.winners_list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Winners',style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      ),
    body: ListView.builder(
      itemCount: winners_list.length,
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text("Ticket No. ${winners_list[index]['id']} -  ${winners_list[index]['title']}"),
        subtitle: Text("Won on - ${winners_list[index]['number_won']}"),
      );
     },
    ),
    );
  }
}