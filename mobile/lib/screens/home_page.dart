import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';
import 'package:housie_bloc/screens/caller.dart';
import 'package:housie_bloc/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Permission.storage.request();
    BlocProvider.of<CallerBloc>(context);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Housie',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width - 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.black,
                child: Text("Generate Tickets",style: TextStyle(fontSize: 30.0,color: Colors.white),),
                onPressed: () async {
//                    var status = Permission.storage.status;
                  if (await Permission.storage.isUndetermined) {
                    Permission.storage.request();
                  }
                  if (await Permission.storage.isDenied) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return permissionDeniedDialog(context);
                        });
                  } else if (await Permission.storage.isGranted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseTickets()));
                  }
                },
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width - 100.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.black,
                child: Text("Start Caller",style: TextStyle(color: Colors.white,fontSize: 30.0),),
                onPressed: () async {
                  final state = BlocProvider.of<CallerBloc>(context).state;
                  if (state is CallerStart) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return EndDialog(
                          title: 'Tickets',
                          text: 'Do you want to add tickets?',
                        );
                      },
                    ).then((value) {
                      if (value) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<CallerBloc>(context),
                        child: DisplayFolders(),
                      );
                    }));
                      }
                      else {
                         Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<CallerBloc>(context),
                        child: Caller(),
                      );
                    }));
                      }
                    });
                  } else if (state is CallerRunning) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<CallerBloc>(context),
                        child: Caller(),
                      );
                    }));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget permissionDeniedDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text("Acess Denied"),
      content: Container(
        height: 60.0,
        width: 100.0,
        child: Center(
          child: AutoSizeText(
            "Please allow Storage Permission for Generating Tickets",
            maxLines: 2,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Allow Again"),
          onPressed: () {
            Navigator.pop(context);
            Permission.storage.request();
          },
        )
      ],
    );
  }
}
