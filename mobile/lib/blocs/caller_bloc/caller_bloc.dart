import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:housie_bloc/models/models.dart';
import 'package:housie_bloc/utils/dbhelper.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'caller_event.dart';
part 'caller_state.dart';

class CallerBloc extends Bloc<CallerEvent, CallerState> {
  @override
  CallerState get initialState => CallerInitial();

  CallerData callerData  = new CallerData();
  DBHelper dbHelper = DBHelper();
  Box box;

  CallerBloc(this.box);

 
  @override
  Stream<CallerState> mapEventToState(
    CallerEvent event,
  ) async* {
    print("event");
    if(event is LoadData) {
      print("called load data event");
      yield* _mapLoadDatatoState();
    }
    else if(event is CallNumber) {
      yield* _mapCallNumbertoState();
    }
    else if(event is ClearCurrentWinners) {
      yield* _mapClearCurrentWinnerstoState();
    }
    else if(event is DataReset) {
      yield* _mapDataResettoState();
    }
 
  
  }


  Future<Map<String,dynamic>> loadData()  async {
    int number = box.get('number');
    List<int> numbers = box.get('numbers');
    String folder_name = box.get('folder_name');
    print("Load $folder_name");
    if((number != null && numbers != null)) {
      return {'number':number,'numbers' : numbers,'folder_name':folder_name};
    }
    else{
      return null;
    }

  }

  Future<void> setFoldeName(String folder_name) async {
    await box.put('folder_name', folder_name);
  }

  Future<void> setData(int number, List<int> numbers) async {
    await box.put('number', number);
    await box.put('numbers', numbers);
  }


  Future<void> clear() async {
    await box.delete('number');
    await box.delete('numbers');
    await box.delete('folder_name');
  }

    Future<void> chooseFolders(String folder_name) async {
    TicketList tickets = await dbHelper.getTickets(folder_name);
    callerData.folder_name = folder_name;
    await setFoldeName(folder_name);
    callerData.ticketsLoaded = tickets;

  }  


  Stream<CallerState> _mapLoadDatatoState()  async* {
    Map _gameData = await loadData();
    if(_gameData != null) {
      callerData.number = _gameData['number'];
      callerData.numbers = _gameData['numbers'];
      if(_gameData['folder_name']!= null) {
                TicketList tickets = await DBHelper().getTickets(_gameData['folder_name']);
       callerData.ticketsLoaded = tickets;
      callerData.ticketsLoaded.getcurrentWinners(callerData.numbers);
      print(callerData.ticketsLoaded.current_winners);
      
    }

      print("called");
      yield CallerRunning(data: callerData);
    }
    else{
      yield CallerStart();
    }
    
  }

    Stream<CallerState> _mapClearCurrentWinnerstoState() async* {
    callerData.clearWinner();
      yield CallerRunning(data: callerData);
    
  }

    Stream<CallerState> _mapCallNumbertoState() async* {
    callerData.genNumber();
    print(this.callerData.numbers);
    await setData(callerData.number, callerData.numbers);
    yield CallerRunning(data: callerData);
    
}

  Stream<CallerState> _mapDataResettoState() async* {
    await clear();
    callerData.numbers.clear();
    callerData.ticketsLoaded.current_winners.clear();
    callerData.ticketsLoaded.winners.clear();
    callerData.ticketsLoaded.winners_list.clear();
    callerData.ticketsLoaded.reset();
    callerData.soundOn = true;
    yield CallerStart();

  }

  void toggleSound() {
    this.callerData.soundOn
     = !this.callerData.soundOn;
  }

}
