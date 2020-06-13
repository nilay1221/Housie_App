import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';
import 'package:housie_bloc/screens/caller.dart';
import 'package:housie_bloc/utils/dbhelper.dart';




class DisplayFolders extends StatefulWidget {
  @override
  _DisplayFoldersState createState() => _DisplayFoldersState();
}

class _DisplayFoldersState extends State<DisplayFolders> {

  var dbhelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Tickets"),
        centerTitle: true
      ),
      body: Container(
        child: FutureBuilder(
          future:this.dbhelper.getFolders() ,
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(snapshot.data[index]['folder_name']),
                    subtitle: Text("Number of Tickets: " + snapshot.data[index]['count'].toString()),
                    onTap: () async{
                     bool y_n = await showDialog(context: context,
                       barrierDismissible: false,
                        builder: (BuildContext context) {
                        return confirmDialog(snapshot.data[index]['folder_name'].toString());
                        }
                      );
                    if(y_n) {
                      await BlocProvider.of<CallerBloc>(context).chooseFolders(snapshot.data[index]['folder_name'].toString());
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return BlocProvider.value(value: BlocProvider.of<CallerBloc>(context),child: Caller(),);
                      }));
                    }

                    },
                  );
                });

          }
            },
        ),
      ),
    );
  }


  Widget confirmDialog(String folderName) {

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Center(child:Text("Confirm") ,),
      content: Container(
        width: 100.0,
        height: 40.0,
        child: AutoSizeText(
          "Do you want to select $folderName folder?",
          maxLines: 2,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
        FlatButton(
          child: Text("No"),
          onPressed: (){
            Navigator.pop(context,false);
          },
        )
      ],
    );

  }

}
