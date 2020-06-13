import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';

class NotificationCard extends StatefulWidget {
  List<String> winners;

  NotificationCard(this.winners);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return _isVisible ?  Container(
      height: 150.0,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black)),
      padding: EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Notifications",
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  BlocProvider.of<CallerBloc>(context).add(ClearCurrentWinners());
                },
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.winners.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 4.0),
                  child: Text("\u2022 ${widget.winners[index]}"),
                );
              },
            ),
          ),
        ],
      ),
    ) : Container();
  }
}