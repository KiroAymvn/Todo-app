import 'package:flutter/cupertino.dart';

class DefText extends StatelessWidget {
  String date;
   DefText({super.key,required this.date});

  @override
  Widget build(BuildContext context) {
    return Text("$date",style: TextStyle(
      fontSize: 35,
      color: Color(0xff57261A) ,


    ),);
  }
}
