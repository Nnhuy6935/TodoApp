import 'package:flutter/material.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/notification_helper.dart';

class ManageTask with ChangeNotifier{
  List<Task> appData = [
    Task("1298023","Test 1", "This is the content of test 1, may be it is too long for the test 1 but I think it's oke ", DateTime(2024,10,29,9,0), TimeOfDay(hour: 9,minute: 0), 15, StatusType.UPCOMING,0),
    Task("2832332", "Test 2", "The short content of test 2", DateTime.now(), TimeOfDay(hour: 10, minute: 15), 0, StatusType.DONE,1),
    Task("283dffe", "Test 3", "The short content of test 3", DateTime(2024,10,26,9,0), TimeOfDay(hour: 10, minute: 15), 0, StatusType.OVERDUE,2),
  ];



  void addNewTask(Task item){
    int currentIdx = appData[appData.length-1].taskIndex;
    item.taskIndex = currentIdx + 1;
    appData.add(item);
    NotificationHelper.showScheduledNotification(data: item);
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
    return output;  
  }
  List<Task> findListTaskByKeyword(String keyword){
    List<Task> output = [];
    for(int i = 0; i < appData.length; ++i){
      if(appData[i].taskTitle.contains(keyword) || appData[i].taskDescription.contains(keyword)){
        output.add(appData[i]);
      }
    }
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
  

  int findTaskInList(String id){
    for(int i = 0; i < appData.length; ++i){
      if(appData[i].taskId == id)
        return i;
    }
    return -1;
  }
  void deleteATask(int index){
    appData.removeAt(index);
    notifyListeners();
  }
  void updateATask(int index, String title, String description, DateTime date, TimeOfDay time, int reminder){
    appData[index].taskTitle = title;
    appData[index].taskDescription = description;
    appData[index].taskDate = date;
    appData[index].taskTime = time;
    appData[index].taskReminder = reminder;
    print("updated");
    notifyListeners();
  }
  void updateTaskStatus(int index, StatusType status){
    appData[index].taskStatus = status; 
    notifyListeners();
  }
}