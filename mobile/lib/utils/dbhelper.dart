import 'package:housie_bloc/models/ticket.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' ;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DBHelper{

    static Database _db ;
    static String FOLDER_NAME = 'folder_name';
    static String TICKET_NUM = 'ticket_num' ;
    static String ROW_1 = 'row_1';
    static String ROW_2 = 'row_2';
    static String ROW_3 = 'row_3';
    static String TABLENAME = 'tickets_details';
    static String DBNAME = 'tickets';


    Future<Database> get db async{
      if(_db != null){
        return _db;
      }
      _db = await initDb();
      return _db;
    }

    initDb() async {
      Directory appdir = await getApplicationDocumentsDirectory();
      print(appdir);
      String path = join(appdir.path,DBNAME);
      var db = await openDatabase(path,version: 1,onCreate: _onCreate);
      return db;

    }

    _onCreate(Database db,int version) async{

      await db.execute("""
          CREATE TABLE $TABLENAME (
            $FOLDER_NAME varchar(255),
            $TICKET_NUM varchar(255),
            $ROW_1 text ,
            $ROW_2 text,
            $ROW_3 text
          );
      """);

    }

    Future<void> save(MyTicket ticket) async {
       var dbClient = await db;
       await dbClient.insert(TABLENAME, ticket.toMap());
    }


    Future<TicketList> getTickets(String folder_name) async {
      var dbClient = await db;
      List<Map> results = await dbClient.rawQuery(""" SELECT * from "$TABLENAME" where $FOLDER_NAME = "$folder_name" """);
      TicketList tickets = TicketList.fromList(results);
      return tickets;

    }
    
    Future<List<Map>> getFolders() async{
      var dbClient = await db;
      List<Map> results = await dbClient.rawQuery("""
          SELECT "$FOLDER_NAME",COUNT("$FOLDER_NAME") as "count" from "$TABLENAME" GROUP BY "$FOLDER_NAME" ;
      """);

      return results;
    }
    




}
