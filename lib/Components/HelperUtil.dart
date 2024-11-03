import 'dart:math';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Helperutil {
  String convertDate(DateTime input){
    String output = "";
    DateTime today = DateTime.now();
    if(input.year == today.year && input.month == today.month && input.day == today.day){
      return "Today".toString();
    }
    if(input.year == today.year && input.month == today.month && input.day == today.day + 1){
      return "Tomorrow".toString();
    }
    return input.year.toString() + "-" + input.month.toString().padLeft(2, '0') + "-" + input.day.toString().padLeft(2, '0');
  }

  int getNumberFromReminder(String reminder){
    String number = reminder.substring(0, reminder.indexOf(" "));
    return int.parse(number);
  }
  String convertToShortString(String input){
    String output = "";
    if(input.length > 35){
      output = input.substring(0,35);
      output += "...";
    }else output = input;
    return output;
  }
  
  String randomId(){
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    
    return List.generate(10, (index) => characters[random.nextInt(characters.length)]).join();
  }
  DateTime combineDateTimeAndTimeOfDate(DateTime date, TimeOfDay time){
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  TZDateTime convertDateTimeToTzDateTime(DateTime time){
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Ho_Chi_Minh');
    TZDateTime convert = tz.TZDateTime.from(time, location);
    return convert;
  }
}