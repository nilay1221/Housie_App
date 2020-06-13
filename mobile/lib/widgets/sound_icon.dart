import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';

class SoundIcon extends StatefulWidget {

  @override
  _SoundIconState createState() => _SoundIconState();
}

class _SoundIconState extends State<SoundIcon> {

  bool _soundOn = true ;

  @override
  Widget build(BuildContext context) {
    return Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 50.0),
            child: IconButton(
                icon: Icon(
                   _soundOn == true ? Icons.volume_up : Icons.volume_off),
                onPressed: () {
                BlocProvider.of<CallerBloc>(context).toggleSound();
                  setState(() {
                    _soundOn = !_soundOn;
                  });
                }),
          );
  }
}