import 'dart:math';

import 'package:housie_bloc/models/models.dart';

class CallerData {
  List<int> numbers;
  String folder_name;
  int number;
  int counter;
  bool soundOn = true;
  TicketList ticketsLoaded;
  Random random = Random();

  CallerData() : this.numbers = List<int>(), this.ticketsLoaded = TicketList.emptyList();

  bool check_number(var numbers, int number) {
    for (var each in numbers) {
      if (each == number) {
        return false;
      }
    }
    return true;
  }

  void genNumber() {
    print(this.numbers);
    while (true) {
      this.number = random.nextInt(91);
      if (check_number(numbers, number) && number != 0) {
        print("break");
        break;
      }
    }
      this.numbers.add(number);
      if(ticketsLoaded.tickets != null) {
      ticketsLoaded.getWinners(number);
      }
  }

  bool get gameEnd => this.numbers.length == 90 ? true :false ;

  List<Map> get winnersList => this.ticketsLoaded.winners_list;

  void clearWinner() {
    this.ticketsLoaded.current_winners = new List<String>();
  }



  // CallerGame(this.numbers,this.number,this.counter,this.soundOn,this.ticketsLoaded);

}
