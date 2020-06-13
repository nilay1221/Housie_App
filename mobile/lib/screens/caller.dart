import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';
import 'package:housie_bloc/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';

class Caller extends StatelessWidget {
  FlutterTts flutterTts = FlutterTts();

  Future _speak(number) async {
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak("$number");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Caller",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Oswald',
                fontWeight: FontWeight.w700,
                fontSize: 23.0),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
             Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          actions: <Widget>[
            BlocBuilder<CallerBloc,CallerState>(
              builder: (context,state) {
                bool _showBadge = false;
                int _numOfwinners;
                if(state is CallerRunning)
                {
                  _numOfwinners = BlocProvider.of<CallerBloc>(context).callerData.winnersList.length;
                  if (_numOfwinners > 0) {
                    _showBadge = true;
                  }
                  else{
                    _showBadge = false;
                  }
                }
                return Badge(
              showBadge: _showBadge,
              animationType: BadgeAnimationType.scale,
              animationDuration: Duration(milliseconds:200),
              position: BadgePosition.topRight(top: 3,right: 5),
              badgeColor: Colors.blue,
                  badgeContent: Text('$_numOfwinners',style: TextStyle(color: Colors.white),),
                          child: IconButton(
                color: Colors.black,
                icon: Icon(Icons.stars),
                onPressed: () {
                  List<Map> winners_list = List.from(BlocProvider.of<CallerBloc>(context).callerData.winnersList.reversed);
                    Navigator.push(context, 
                      CupertinoPageRoute(builder: (context) => Winners(winners_list: winners_list,))
                    );
                },
              ),
            );
              }
            ),
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.view_module),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: MyApp(),
                        settings: RouteSettings(arguments: {
                          'numbers': BlocProvider.of<CallerBloc>(context)
                              .callerData
                              .numbers
                        })));
              },
            )
          ],
        ),
        body: BlocBuilder<CallerBloc, CallerState>(
          builder: (context, state) {
            if (state is CallerStart) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    playIcon(),
                    SizedBox(
                      height: 30.0,
                    ),
                    StartButton(
                      text: 'Start',
                    ),
                    SoundIcon(),
                  ],
                ),
              );
            } else if (state is CallerRunning) {
              if (state.soundOn) {
                _speak(state.number);
              }
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                             RestartIcon(),
                             Align(
                             alignment: Alignment.topCenter,
                             child: NumberDisplay(state.number) )
                      ],
                    ),
                    SizedBox(
                        height: 50.0,
                        width: 200.0,
                        child: getListView(state.numbers)),
                    state.winners.length > 0 && state.winners != null
                        ? NotificationCard(state.winners) // FIXME fix screen rebuilt
                        : Container(),
                    SizedBox(
                      height: 30.0,
                    ),
                    StartButton(
                      text: 'Next',
                    ),
                    SoundIcon()
                  ]);
            }
          },
          condition: (prevstate, state) {
            return true;
          },
        ));
  }
}
