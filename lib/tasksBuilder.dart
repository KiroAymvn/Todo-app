import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class tasksBuilder extends StatelessWidget {
  List<Map<dynamic,dynamic>> tasksList=[];

  tasksBuilder({super.key,required this.tasksList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 10.h,
      width: 80.w,
      decoration: BoxDecoration(
        color:Color(0xff57261A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text("}"),
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}
