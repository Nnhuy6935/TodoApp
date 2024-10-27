import 'dart:math';

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
}