import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Components/ColorStyle.dart';
import 'package:todo_app/Components/HelperUtil.dart';
import 'package:todo_app/Model/ManageTaskState.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Views/newTask.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen>{
  Mode currentMode = Mode.ALL;
  List<bool> buttonStatus = [true,false,false];
  Color selectedButton = Colorstyle().btnColor;
  Color unSelectedButton = Colorstyle().btnLightColor;
  Color selectedText = Colorstyle().textColor1;
  Color unselectedText = Colorstyle().textColor2;
  List<Task> data = [];
  int mode = 0;
  @override
  Widget build(BuildContext context) {
    final taskModel = Provider.of<ManageTask>(context);
    return Scaffold(
      backgroundColor: Colorstyle().bgColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SEARCH AREA 
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        labelText: "Keyword",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.search)
                  )
                ],
              ),

              //CATEGORY TASK BUTTONS 
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colorstyle().btnLightColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //BUTTON ALL 
                    Container(
                      width: 110,
                      margin: EdgeInsets.all(2),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            mode = 0;
                            for(int i = 0 ; i < buttonStatus.length; ++i){
                              if(i == 0)
                                buttonStatus[i] = true;
                              else buttonStatus[i] = false; 
                            }
                          });
                        }, 
                        child: Text(
                          "All",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: buttonStatus[0] ? selectedText : unselectedText
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonStatus[0] ? selectedButton : unSelectedButton,
                        ),
                      ),
                    ),
                    //BUTTON TODAY
                    Container(
                      width: 110,
                      margin: EdgeInsets.all(2),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            mode = 1;
                            for(int i = 0 ; i < buttonStatus.length; ++i){
                              if(i == 1)
                                buttonStatus[i] = true;
                              else buttonStatus[i] = false; 
                            }
                          });
                        }, 
                        child: Text(
                          "Today",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: buttonStatus[1] ? selectedText : unselectedText
                          ),  
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonStatus[1] ? selectedButton : unSelectedButton,
                        ),
                      ),
                    ),
                    //BUTTON UPCOMING
                    Container(
                      width: 110,
                      margin: EdgeInsets.all(2),
                      child: ElevatedButton(
                        onPressed: (){
                          setState((){
                            mode = 2;
                            for(int i = 0 ; i < buttonStatus.length; ++i){
                              if(i == 2)
                                buttonStatus[i] = true;
                              else buttonStatus[i] = false; 
                            }
                          });
                        }, 
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: buttonStatus[2] ? selectedText : unselectedText
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonStatus[2] ? selectedButton : unSelectedButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // LIST NOTE 
              Expanded(
                child: ListView.builder(
                  // itemCount: data.length,
                  itemCount: taskModel.getTaskByFilter(mode).length,
                  itemBuilder: (BuildContext context, int index){
                    final task = taskModel.getTaskByFilter(mode);
                    return Card(
                      color: (task[index].taskStatus == StatusType.DONE ? Colorstyle().doneTaskLightColor: (task[index].taskStatus == StatusType.OVERDUE ? Colorstyle().overdueTaskLightColor : Colorstyle().upcommingTaskLightColor)),
                      child: ListTile(
                        trailing: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                          children: [
                            Icon( (task[index].taskReminder != 0) ? Icons.timer_outlined : Icons.timer_off_outlined),
                            Text(
                              task[index].taskTime.format(context),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        ),
                        title: Text(
                          task[index].taskTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: task[index].taskStatus == StatusType.DONE ? Colorstyle().doneTaskColor: (task[index].taskStatus == StatusType.OVERDUE ? Colorstyle().overdueTaskColor : Colorstyle().upcommingTaskColor)
                          ),
                        ),
                        subtitle: Text(Helperutil().convertToShortString(task[index].taskDescription)),
                      ),
                    );
                  }
                ),
              ),
            ],
          ), 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: selectedButton,
        onPressed:(){
          //NAVIGATE TO ADD NEW TASK SCREEN 
          Navigator.pushNamed(context, "/addnew");
        },
        child: Icon(Icons.add),  
      ),
    );
  }

  
}