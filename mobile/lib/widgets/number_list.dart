  import 'package:flutter/material.dart';

Widget getListView(List<int> numbers) {
    var new_numbers = new List.from(numbers.reversed);
    return ListView.builder(
//        reverse: true,
        shrinkWrap: true,
        itemCount: new_numbers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var numberadd = new_numbers[index];
          // print("numberadd $numberadd");
          return Text(
            " $numberadd ",
            style: TextStyle(
                fontSize: 25.0, fontFamily: 'Montserrat', color: Colors.black),
          );
        });
  }
