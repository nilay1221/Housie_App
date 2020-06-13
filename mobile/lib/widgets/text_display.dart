  import 'package:flutter/material.dart';

class NumberDisplay extends StatefulWidget {

  final int number;

  NumberDisplay(this.number);

  @override
  _NumberDisplayState createState() => _NumberDisplayState();
}

class _NumberDisplayState extends State<NumberDisplay> with TickerProviderStateMixin {

  AnimationController controller;
  Animation _animation;
  @override
  void initState() { 
    super.initState();
    print("initstate");
    
  }

  @override
  Widget build(BuildContext context) {
    var _tween = Tween<double>(begin: 1.0,end: widget.number.toDouble());
   this.controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,

    )..forward();
    var animation = _tween.animate(CurvedAnimation(parent: controller,curve: Curves.easeOut));
    return AnimatedBuilder(
          animation: animation,
          
          builder: (context,state) {    
            return    Text(
        "${animation.value.toInt()}",
        style: TextStyle(
          fontSize: 170.0,
          fontFamily: 'Montserrat',
          color: Colors.black,
        ),
      );
          }
    );
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}