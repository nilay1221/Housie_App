import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';
import 'package:housie_bloc/widgets/widgets.dart';

class StartButton  extends StatelessWidget {

  final String text;

  StartButton({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 60.0,
            width: 250.0,
            child: RaisedButton(
              child: Text(
                "$text",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if(BlocProvider.of<CallerBloc>(context).callerData.gameEnd) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return EndDialog(title: 'Housie Complete',text: 'Would you like to start new round?',);
                      },
                    ).then((value){
                      if(value) {
                        BlocProvider.of<CallerBloc>(context).add(DataReset());
                      }
                    });
                }
                else {
                BlocProvider.of<CallerBloc>(context).add(CallNumber());

                }


                // if (counter == 0) {hometest
                //   await setData();
                // }

                // setState(() {
                //   if (counter == 0) {
                //     this.start = "Next";
                //     this.gameStart = true;
                //   }
                //   if (counter <= 89) {
                //     while (true) {
                //       number = random.nextInt(91);
                //       if (check_number(numbers, number) && number != 0) {
                //         break;
                //       }
                //     }
                //     numbers.add(number);
                // if (this.soundOn) {
                //   _speak(number);
                // }

                //     this.tickets_loded.getWinners(number);
                //     print(this.tickets_loded.current_winners);
                //     if (this.tickets_loded.current_winners.length > 0) {
                //       showDialog(
                //         context: context,
                //         barrierDismissible: false,
                //         builder: (BuildContext context) {
                //           return showWinnerDialog(
                //               this.tickets_loded.current_winners);
                //         },
                //       );
                //     }
                //     counter += 1;
                //   } else {
                //     showDialog(
                //       context: context,
                //       barrierDismissible: false,
                //       builder: (BuildContext context) {
                //         return housieEndAlert();
                //       },
                //     );
                //   }
                // });
                // if (counter <= 89) {
                //   await setGameData();
                // }
              },
              color: Color(0xffa55eea),
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
            ),
          );
  }
}