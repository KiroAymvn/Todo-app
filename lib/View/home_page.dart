import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/View/task_page.dart';
import 'package:noteapp/constant.dart';
import 'package:noteapp/data/local_data.dart';
import 'package:noteapp/widgets/default_text.dart';
import 'package:noteapp/widgets/default_text_form_field.dart';
import 'package:sizer/sizer.dart';

import 'Delete_page.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShowBottomSheet=false;
  List<Widget> screensList=[
    TaskPage(),
    DeletePage()
  ];
  @override
  void initState() {
    createDataBase();
    super.initState();
  }
  var Scaffoldkey =GlobalKey<ScaffoldState>();
  var formKey =GlobalKey<FormState>();
  int currentIndex=0;
//Color(0xffFBF8D9) off white 
//Color(0xff57261A) brown
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Scaffoldkey,
      appBar: AppBar(
        title: DefText(date: "TaskPage"),
        backgroundColor: Color(0xffFBF8D9),
        centerTitle: true,

      ),
      body: screensList[currentIndex],

      backgroundColor: Color(0xffFBF8D9),

floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add,color:Color(0xffFBF8D9) ,),
  backgroundColor: Color(0xff57261A),
  shape: CircleBorder(),
    onPressed: ()
    {

      if(isShowBottomSheet)
        {if(formKey.currentState!.validate())
        {
          setState(() {
            insertDataBase(
                title: taskController.text ,
                date: dateController.text,
                time:timeController.text
            );
            Navigator.pop(context);
            taskList.add(taskList[currentIndex]);
          });

        }}
      else{
        isShowBottomSheet=true;
      Scaffoldkey.currentState?.showBottomSheet((context){
        return Container(
          padding: EdgeInsets.all(10),
          height: 22.h,
          decoration: BoxDecoration(
            color: Color(0xff57261A),borderRadius: BorderRadius.circular(20),

          ),
          child: Form(
            key:formKey ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextFormField(controller: taskController,
                  hint: 'Task',
                  suffixIcon: Icon(Icons.task),
                  valid: (String?value ) {
                    if(value!.isEmpty){
                      return "please enter valid task";

                    }
                    return null;
                  },
                  keyboard: TextInputType.name,

                ),
                SizedBox(height: 10,),
                DefaultTextFormField(controller: dateController,
                    hint: "Date",
                    onTap: () async {
                      await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025,10,1)).then((value){print(value);
                      dateController.text=DateFormat.yMd().format(value!);

                      });
                    },

                    suffixIcon: Icon(Icons.date_range),
                    valid: (String?value){
                      if(value!.isEmpty){
                        return "please enter date";
                      }
                      return null;
                    }, keyboard: TextInputType.datetime),
                SizedBox(height: 10,),


                DefaultTextFormField(controller: timeController,
                    hint: "Time",
                    onTap: ()
                    async{
                      await showTimePicker(context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value){
                        timeController.text=value!.format(context).toString();
                      });
                    },
                    suffixIcon: Icon(Icons.timer),
                    valid: (value){
                      if(value!.isEmpty){
                        return "Please enter time";

                      }
                      return null;
                    }, keyboard: TextInputType.datetime)
              ],
            ),
          ),
        );
      }).closed.then((value){
        print("closed");
      });}
    }
),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.white  ,
        currentIndex: currentIndex,
          onTap: (index){
          setState(() {
currentIndex=index;
          });

          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task,color: Color(0xff57261A),),label: "Task",backgroundColor:Color(0xff57261A),),
            BottomNavigationBarItem(icon: Icon(Icons.delete,color:Color(0xff57261A) ,),label: "Delete",backgroundColor:Color(0xff57261A)),
          ]),
    );
  }
}
