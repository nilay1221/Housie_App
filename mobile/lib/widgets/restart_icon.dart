import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';
import 'package:housie_bloc/widgets/widgets.dart';

class RestartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10.0,
      child: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return EndDialog(
                  title: 'Restart',
                  text: 'Are you sure want to restart game?',
                );
              },
            ).then((value) {
              if (value) {
                BlocProvider.of<CallerBloc>(context).add(DataReset());
              }
            });
          }),
    );
  }
}
