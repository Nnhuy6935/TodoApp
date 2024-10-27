import 'package:flutter/material.dart';

class Task{
  late String taskId;
  late String taskTitle;
  late String taskDescription;
  late DateTime taskDate;
  late TimeOfDay taskTime;
  late int taskReminder;
  late StatusType taskStatus;
  Task(String id, String title, String description, DateTime date, TimeOfDay hour, int remind, StatusType status){
    this.taskId = id;
    this.taskTitle = title;
    this.taskDescription = description;
    this.taskDate = date;
    this.taskTime = hour;
    this.taskReminder = remind;
    this.taskStatus = status;
    
  }
}

enum StatusType{
  UPCOMING, DONE, OVERDUE
}
enum Mode{
  ALL, TODAY, UPCOMING
}