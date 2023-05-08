import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../../data/model/house_rules_model.dart';
import '../../../../../data/sources/cache/logged_user.dart';
import '../../../../../infra/services/house_rules_service.dart';
import '../../../../../utils/message.dart';

class HouseRulesListController with ChangeNotifier{
  late HouseRulesService houseRulesService;
  //late HouseRulesModel houseRulesModel;
  late ScrollController scrollController;
  LoggedUser? loggedUser;
  final loading = ValueNotifier(true);
  final progress = ValueNotifier(false);
  bool? show = false;

  void getPreferences() async {
    loggedUser = LoggedUser();
    LoggedUser loggedUserTemp = await LoggedUser().readPreferences();

    loggedUser = loggedUserTemp;
    if(loggedUser!.active) {
      show = true;
    }
    notifyListeners();
  }

  loadHouseRules( ) async {
      progress.value = !progress.value;
      notifyListeners();
    try{
      await houseRulesService.getEntities();
    }catch(error){
      //showError(error,context);
      print(error);
    }
      progress.value = !progress.value;
      notifyListeners();
  }

  infiniteScrolling() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent &&
        loading.value) {
      loadHouseRules();
    }
  }

  void noDelete(BuildContext context){
    Message.snackMessage(
        Colors.red, 'You should be logged to delete rules', null, context);
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/searchList', (route) => false);
    });
  }

  void delete(String id,BuildContext context) async {
    try {
      bool delete = await HouseRulesService().deleteEntity(int.parse(id));
      if (delete) {
        Message.snackMessage(
            Colors.black26, 'House Rule removed successfully', null, context);
        Timer(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/searchList', (route) => false);
        });
      } else {
        Message.snackMessage(
            Colors.black26, 'House Rule removed error', null, context);
      }
    }catch(error){
      Message.snackMessage(Colors.red, error, null, context);
      Navigator.pushNamedAndRemoveUntil(context, '/searchList', (route) => false);
    }
  }

  void showError(message,context){
    Message.snackMessage(Colors.red,message,null,context);
  }

}