import 'dart:convert';
import "dart:math";



class TicketList{

  List<MyTicket> tickets;
  Map<String,List<int>> winners = new Map<String,List<int>>();
  List<Map> winners_list = new List<Map>();
  List<String> current_winners  = new List<String>();


  TicketList({
    this.tickets
});

  factory TicketList.fromJson(List<dynamic> parsedJson,String folder_name){

    List<MyTicket> tickets = new List<MyTicket>();
    tickets = parsedJson.map((i) => MyTicket.fromJson(i,folder_name)).toList();

    return new TicketList(
      tickets: tickets
    );
  }

   TicketList.fromList(List<Map> query) {

    this.tickets = query.map((i) => MyTicket.fromMap(i)).toList();
  }


  TicketList.emptyList();


  void addWinner(String prize_name,int ticket_id,String prize_display,int number_called) {
      if(this.winners[prize_name] == null)
        {
          this.winners[prize_name] = new List<int>();
        }
      if(!(this.winners[prize_name].contains(ticket_id))){
        winners[prize_name].add(ticket_id);
        this.current_winners.add("Ticket no. $ticket_id has won $prize_display");
        this.winners_list.add({'title':prize_display,'id':ticket_id,'number_won':number_called});
      }

  }
  
  void getWinners(int number_called){

    var previous_winners = this.current_winners;
    this.current_winners = new List<String>();
    this.tickets.forEach((ticket){
      ticket.mark_numbers(number_called);
      // print("Corner Count : ${ticket.corner_count}");
      if(ticket.row1_count == 5) addWinner('row_1', ticket.ticket_id,'Row 1',number_called);
      if(ticket.row2_count == 5) addWinner('row_2', ticket.ticket_id,'Row 2',number_called);
      if(ticket.row3_count == 5) addWinner('row_3', ticket.ticket_id, 'Row 3',number_called);
      if(ticket.corner_count == 4) addWinner('corners', ticket.ticket_id, '4 Corners',number_called);
      if(ticket.row1_count == 5 && ticket.row2_count == 5 && ticket.row3_count == 5 ) addWinner('Full Housie', ticket.ticket_id, 'Full Housie',number_called);

    });

    if(this.current_winners.length == 0) {
      this.current_winners = previous_winners;
    }
   
  }


   void getcurrentWinners(List<int> numbers) {
     if(numbers != null) {
       numbers.forEach((number) {
          getWinners(number);
         });
     }
        
    }

    void reset() {
      if(this.tickets != null) {

        this.tickets.forEach((ticket) {
        ticket.reset();
       });
    }
      }
     
  

}





class MyTicket{



  int ticket_id ;
  String folder_name;

  List<int> row1;
  List<int> row2;
  List<int> row3;

  int row1_count = 0,row2_count = 0,row3_count = 0,corner_count = 0;
  List<int> corner_items = new List<int>();

  MyTicket(this.folder_name,this.ticket_id,this.row1,this.row2,this.row3){
//     print(this.row1);
    find_corner_indices();
  }



  void find_corner_indices(){


    bool corner1,corner2,corner3,corner4;
    corner1 = false;
    corner2 = false;
    corner3 = false;
    corner4 = false;


    int i;
    for(i =0;i<9;i++)
    {
      if(this.row1[i]!=0 && corner1 == false){
        this.corner_items.add(row1[i]);
        corner1 = true;
      }
      if(this.row1[8-i] != 0 && corner2 == false ){
        this.corner_items.add(row1[8-i]);
        corner2 = true;
      }
      if(this.row3[i] !=0 && corner3 == false){
        this.corner_items.add(row3[i]);
        corner3 = true;
      }
      if(this.row3[8-i] != 0 && corner4 == false ){
        this.corner_items.add(row3[8 -i]);
        corner4 = true;
      }

      if(corner1 && corner2 && corner3 && corner4){
        break;

      }

    }

  }


  void mark_numbers(int number_called){


    if(this.row1.contains(number_called)) this.row1_count += 1;
    else if(this.row2.contains(number_called)) this.row2_count += 1;
    else if(this.row3.contains(number_called)) this.row3_count += 1;

    if(this.corner_items.contains(number_called)) this.corner_count += 1;


  }

    factory MyTicket.fromJson(Map<dynamic,dynamic> json,String folder_name) {
        return new MyTicket(folder_name,json['ticket_num'], json['row_1'].cast<int>(), json['row_2'].cast<int>(), json['row_3'].cast<int>());
    }


    Map<String,dynamic> toMap () {

      var map = <String,dynamic>{
        'folder_name':this.folder_name,
        'ticket_num' : this.ticket_id,
        'row_1' : jsonEncode(this.row1),
        'row_2' : jsonEncode(this.row2),
        'row_3' : jsonEncode(this.row3),
      };

      return map;
    }


   factory MyTicket.fromMap(Map<String,dynamic> map) {
        return new MyTicket(map['folder_name'], int.parse(map['ticket_num']), jsonDecode(map['row_1']).cast<int>(), jsonDecode(map['row_2']).cast<int>(), jsonDecode(map['row_3']).cast<int>());
    }

    void reset() {
      this.row1_count = 0;
      this.row2_count = 0;
      this.row3_count = 0;
      this.corner_count = 0;
    }

}