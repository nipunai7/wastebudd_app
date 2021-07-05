import 'package:shared_preferences/shared_preferences.dart';

class Dustbin{

  static SharedPreferences sharedPreferences;

  static String id = 'id';
  static String name = 'name';
  static String dateCreated = 'dateCreated';
  static double weight = 0.0;
  static double temp = 0.00;
  static double humidity = 0.00;
  static String user = 'userID';


}