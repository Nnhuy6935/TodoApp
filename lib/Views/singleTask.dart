import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Components/ColorStyle.dart';
import 'package:todo_app/Components/HelperUtil.dart';
import 'package:todo_app/Model/ManageTaskState.dart';
import 'package:todo_app/Model/Task.dart';

class SingletaskScreen extends StatefulWidget{
  late int index ;
  late Task data;
  SingletaskScreen({required int index, required Task data}){
    this.index = index;
    this.data = data;
  }
  @override
  State<StatefulWidget> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingletaskScreen> {
  late int index;
  late Task data;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  String reminder = "reminder";
  late TextEditingController titleController ;
  late TextEditingController descConroller ;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    this.index = widget.index;
    this.data = widget.data;
    selectedDate = data.taskDate;
    selectedTime = data.taskTime;
    if(data.taskReminder == 0)
      reminder = "Reminder";
    else reminder = data.taskReminder.toString() + " minutes";
    titleController = TextEditingController(text: data.taskTitle);
    descConroller = TextEditingController(text: data.taskDescription);
  }

  @override
  Widget build(BuildContext context) {
    final taskModel = Provider.of<ManageTask>(context);
    print(taskModel.get()[index].taskIndex);
    print(taskModel.get()[index].taskTitle);
    print(taskModel.get()[index].taskDate);
    print(taskModel.get()[index].taskTime);
    print(Helperutil().convertDateTimeToTzDateTime(taskModel.get()[index].taskDate).toString());
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          !editMode ? 
            TextButton(
              onPressed: (){
                //DELETE TASK OR MARK AS COMPLETE TASK
                if(data.taskStatus == StatusType.DONE){
                  taskModel.deleteATask(index);
                }else{
                  taskModel.updateTaskStatus(index, StatusType.DONE);
                }
                Navigator.pop(context);
              }, 
              child: Text(
                data.taskStatus == StatusType.DONE ? "Delete Task" : "Mark as complete",
                style: TextStyle(
                  color: data.taskStatus == StatusType.DONE ? Colors.red : Colors.green
                ),  
              ),
            ) : TextButton(
              onPressed: (){
                setState(() {
                  editMode = false;
                });
              }, 
              child: Text("Cancel")
            ),
          !editMode ?
            IconButton(
              onPressed: (){
                setState(() {
                  editMode = true;
                });
              }, 
              icon: Icon(Icons.edit),
            ) : 
            TextButton(
              onPressed: (){
                // CHANGE INFORMATION OF TASK
                
                // print(titleController.value.text);
                // print(descConroller.value.text);
                // print(selectedDate.toString());
                // print(selectedTime.format(context));
                // print(reminder);
                setState(() {
                  taskModel.updateATask(index, titleController.value.text, descConroller.value.text, Helperutil().combineDateTimeAndTimeOfDate(selectedDate,selectedTime), selectedTime, Helperutil().getNumberFromReminder(reminder));
                  editMode = false;
                });
              }, 
              child: Text("Save"),
            ),
          
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              //TITLE
              TextField(
                readOnly: !editMode,
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
                readOnly: !editMode,
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
                      child: AbsorbPointer(
                        absorbing: !editMode,
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
                      )
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
                      child: AbsorbPointer(
                        absorbing: !editMode,
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
                      child: AbsorbPointer(
                        absorbing: !editMode,
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
                                // taskModel.get()[index].taskReminder.toString() + " minutes before",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),  
                              )
                            ],
                          ),
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