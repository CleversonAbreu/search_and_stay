import 'package:flutter/material.dart';
import '../../../../data/sources/cache/logged_user.dart';
import '../../../../utils/message.dart';

class LoginController extends ChangeNotifier{

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController     = TextEditingController();
  LoggedUser? loggedUser= LoggedUser();
  final bool obscurePassword = false;
  late  bool isLoading       = false;

  void _loading() {
      isLoading = !isLoading;
      notifyListeners();
  }

  void setPreferences() => LoggedUser().setPreferences(true);

  void getPreferences() async {
    LoggedUser loggedUserTemp = await LoggedUser().readPreferences();
    if (!loggedUserTemp.active) {
      loggedUser = loggedUserTemp;
      notifyListeners();
    }
  }

  void validateFields(String username, String password,BuildContext context) {
      _loading();
      if (username == '' || password == '') {
        Message.snackMessage(
            Colors.red, 'Enter username and password', null, context);
      } else if (username != 'admin' && password != 'admin') {
         Message.snackMessage(Colors.red, 'Sorry, user not found with this data',
             null, context);
      } else {
        setPreferences();
        Navigator.pushNamedAndRemoveUntil(context, '/searchList',
                (route) => false);
      }
      _loading();
  }

}