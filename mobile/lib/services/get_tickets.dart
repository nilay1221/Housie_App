import 'package:flutter/cupertino.dart';
import 'package:housie_bloc/models/ticket.dart';
import 'package:housie_bloc/utils/dbhelper.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class GetTickets {

  int numberOfTickets ;
  String folderName;
  GetTickets({ @required this.numberOfTickets});

  Future<List<dynamic>> get_tickets() async {

    var url = "http://192.168.0.105:5000/get_tickets/$numberOfTickets/";
//    print(url);
    var response = await http.get(url);
    if(response.statusCode == 200){
       var body = jsonDecode(response.body);
//       print(body);
        return body;
    }
    else
      {
        throw Exception();
      }

  }

  getLastNumber() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var last = preferences.getInt('tickets_gen') ?? 1 ;
    return last;
  }

  setLastNumber(int number) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var last = preferences.setInt('tickets_gen', number );
  }


  Future<String> createFolder() async{

    var number = await getLastNumber();
//    print(number);
    this.folderName = "Tickets_$number";
    var main_folder = Directory("storage/emulated/0/Housie/");
    if(await main_folder.exists() == false)
      {
        main_folder.create();
      }
    var folder_path = Directory("storage/emulated/0/Housie/Tickets_$number");
    if(await folder_path.exists() == false)
      {
        folder_path.create();
      }
    setLastNumber(number+1);
    return folder_path.path;
}

  Future<void> saveTickets() async {
      List<dynamic> tickets = await get_tickets();
      String folder_path = await createFolder();
      tickets.forEach((ticket) {
        try {
          var ticket_number = ticket['ticket_num'];
          var value = ticket['img'];
          var file_path = "$folder_path/$ticket_number.png";
          var decoded = base64Decode(value);
          File file = File(file_path);
          file.writeAsBytes(decoded);
        }catch(e)
        {
          print(e);
        }
      }

      );

      TicketList ticket_list = TicketList.fromJson(tickets, this.folderName);
      var dbhelper = DBHelper();
      ticket_list.tickets.forEach((ticket){
        dbhelper.save(ticket);
      });

      TicketList mytickets = await dbhelper.getTickets(this.folderName);
      print(mytickets.tickets[0].row1);


  }
    }



