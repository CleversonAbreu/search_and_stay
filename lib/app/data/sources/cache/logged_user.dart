import 'package:shared_preferences/shared_preferences.dart';

class LoggedUser {

  late bool active;

  setPreferences(active) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('active', active);
  }

  readPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    active =  prefs.getBool('active') ?? false;
    return this;
  }

  clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
  }

}