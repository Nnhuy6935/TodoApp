import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Components/ColorStyle.dart';
import 'package:todo_app/Components/HelperUtil.dart';
import 'package:todo_app/Model/ManageTaskState.dart';
import 'package:todo_app/Model/Task.dart';

class NewTaskScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTaskScreen>{
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  String reminder = "reminder";
  final titleController = TextEditingController();
  final descConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskModel = Provider.of<ManageTask>(context);
    return Scaffold(
      backgroundColor: Colorstyle().bgColor,
      appBar: AppBar(
        backgroundColor: Colorstyle().bgColor,
        leading: BackButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: (){
              String id = Helperutil().randomId();
              String title = titleController.value.text;
              String description = descConroller.value.text;
              DateTime date = selectedDate;
              TimeOfDay hour = selectedTime;
              int remind = 0;
              if(!reminder.contains("reminder"))
                remind = Helperutil().getNumberFromReminder(reminder);
              StatusType status = StatusType.UPCOMING;
              taskModel.addNewTask(Task(id,title,description,date,hour,remind,status));
              Navigator.pop(context);
            }, 
            child: Text("Save"),
          )
        ],
      ),
      
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              //TITLE
              TextField(
                controller: titleController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // fontSize: 20,
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
              ),
              //DESCRIPTION
              TextField(
                controller: descConroller,
                maxLines: 10,
                minLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "description",
                ),
              ),
              // ADDITIONAL INFORMATION 
            
              Container(
                height: 30,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    //SELECT DATE
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade400,
                        )
                      ),
                      child: GestureDetector(
                        onTap: () async{
                          DateTime? select = await showDatePicker(
                            context: context, 
                            initialDate: selectedDate,
                            firstDate: DateTime(2000), 
                            lastDate: DateTime(2050),
                          );
                          if(select != null){
                            setState(() {
                              selectedDate = select;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month, color: Colorstyle().doneTaskColor,),
                            Text(
                              Helperutil().convertDate(selectedDate),
                              style: TextStyle(
                                color: Colorstyle().doneTaskColor,
                              ),  
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    //SELECT TIME 
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade400,
                        )
                      ),
                      child: GestureDetector(
                        onTap: ()async{
                          TimeOfDay? time = await showTimePicker(
                            context: context, 
                            initialTime: selectedTime
                          );
                          if(time != null){
                            setState(() {
                              selectedTime = time;                              
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Colorstyle().doneTaskColor,),
                            Text(
                              selectedTime.format(context),
                              style: TextStyle(
                                color: Colorstyle().doneTaskColor,
                              ),  
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    //REMINDER 
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade400,
                        )
                      ),
                      child: GestureDetector(
                        onTap: (){
                          _showReminderDialog(context);
                          
                        },
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.grey,),
                            SizedBox(width: 3,),
                            Text(
                              reminder,
                              style: TextStyle(
                                color: Colors.grey,
                              ),  
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showReminderDialog(BuildContext context){
    String output = "";

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 160,
            width: 200,
            child: ListView(
              children: [
                TextButton(
                  onPressed: (){
                    output = "10 minutes";
                    setState(() {
                      reminder = output;
                    });
                    Navigator.of(context).pop();
                  }, 
                  child: Text(
                    "10 minutes before",
                    style: TextStyle(
                      fontSize: 20,
                    ),  
                  ),
                ),
                TextButton(
                  onPressed: (){
                    output = "15 minutes";
                    setState(() {
                      reminder = output;
                    });
                    Navigator.of(context).pop();
                  }, 
                  child: Text(
                    "15 minutes before",
                    style: TextStyle(
                      fontSize: 20,
                    ),  
                  ),
                ),
                TextButton(
                  onPressed: (){
                    output = "30 minutes";
                    setState(() {
                      reminder = output;
                    });
                    Navigator.of(context).pop();
                  }, 
                  child: Text(
                    "30 minutes before",
                    style: TextStyle(
                      fontSize: 20,
                    ),  
                  ),
                ),
                
              ],
            ),
          )
        );
      }
    );
  }
  
}