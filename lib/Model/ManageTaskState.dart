import 'package:flutter/material.dart';
import 'package:todo_app/Model/Task.dart';

class ManageTask with ChangeNotifier{
  List<Task> appData = [
    Task("1298023","Test 1", "This is the content of test 1, may be it is too long for the test 1 but I think it's oke ", DateTime(2024,10,29,9,0), TimeOfDay(hour: 9,minute: 0), 15, StatusType.UPCOMING),
    Task("2832332", "Test 2", "The short content of test 2", DateTime.now(), TimeOfDay(hour: 10, minute: 15), 0, StatusType.DONE),
    Task("283dffe", "Test 3", "The short content of test 3", DateTime(2024,10,26,9,0), TimeOfDay(hour: 10, minute: 15), 0, StatusType.OVERDUE),

  ];
  void addNewTask(Task item){
    appData.add(item);
    notifyListeners();
  }
  List<Task> get() => appData;
  List<Task> todayTasks(){
    List<Task> output = [];
    for(int i = 0; i < appData.length; ++i){
      DateTime date = appData[i].taskDate;
      DateTime current = DateTime.now();
      if(date.day == current.day && date.month == current.month && date.year == current.year){
        output.add(appData[i]);
      }
    }
    // notifyListeners();
    return output;  
  }

  List<Task> upcomingTasks(){
    List<Task> output = [];
    for(int i = 0; i < appData.length; ++i){
      DateTime date = appData[i].taskDate;
      DateTime current = DateTime.now();
      if(date.isAfter(current)){
        output.add(appData[i]);
      }
    }
    // notifyListeners();
    return output;  
  }

  List<Task> getTaskByFilter(int mode){
    List<Task> output = [];
    if(mode == 0) 
      return get();
    if(mode == 1)
      return todayTasks();
    else return upcomingTasks();
  }
}