import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../data/model/house_rules_model.dart';
import '../../../../../data/sources/cache/logged_user.dart';
import '../../../../../infra/services/house_rules_service.dart';
import '../../../../../utils/message.dart';

class HouseRulesUpdateController with ChangeNotifier {
  final TextInputType numberType = TextInputType.number;
  final TextInputType textType = TextInputType.text;

  late HouseRulesModel houseRulesModel;
  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  late int order;
  late int active = 0;
  bool? show = false;
  late LoggedUser loggedUser;

  late String nameHelperText = '';
  late String orderHelperText = '';
  late String idHelperText = '';

  late FocusNode nameNode;
  late FocusNode orderNode;
  late FocusNode idNode;

  final Icon orderIcon = const Icon(Icons.edit_calendar, size: 30);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  void loading() {
    isLoading.value = !isLoading.value;
    notifyListeners();
  }

  void toCheck(value) {
    isChecked!.value = value!;
    notifyListeners();
  }

  void getEntity(id,context) async {
    try {
      HouseRulesModel houseRulesModel = await HouseRulesService().getEntity(id);
      idController.text = houseRulesModel.id.toString();
      nameController.text = houseRulesModel.name;
      orderController.text = houseRulesModel.order.toString();
      houseRulesModel.active == 1
          ? isChecked.value = true
          : isChecked.value = false;
    }catch(error){
      showError(error,context);
    }
    loading();
    notifyListeners();
  }

  void getPreferences() async {
    loggedUser = LoggedUser();
    LoggedUser loggedUserTemp = await LoggedUser().readPreferences();

    loggedUser = loggedUserTemp;
    if (loggedUser!.active) {
      show = true;
    }
    notifyListeners();
  }

  bool? validateFields(BuildContext context) {
    if (nameController.text == '' || orderController.text == '') {
      if (nameController.text == '') {
        nameNode.requestFocus();
        Message.snackMessage(Colors.red, 'Name is required', null, context);
        return false;
      }
      if (orderController.text == '') {
        orderNode.requestFocus();
        Message.snackMessage(Colors.red, 'Order is required', null, context);
        return false;
      }
    }
    active = isChecked.value == true ? 1 : 0;
    order = int.parse(orderController.text);

    HouseRulesModel? houseRulesModel = HouseRulesModel(
        id: int.parse(idController.text),
        name: nameController.text,
        active: active,
        order: int.parse(orderController.text));
    _send(houseRulesModel!, context);
    return null;
  }

  void _send(HouseRulesModel houseRulesModel, BuildContext context) async {
    loading();
    try {
      bool update = await HouseRulesService()
          .updateEntity(houseRulesModel.id!, houseRulesModel);
      if (update) {
        Message.snackMessage(
            Colors.black26, 'House Rule updated successfully', null, context);
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/searchList', (route) => false);
        });
      } else {
        Message.snackMessage(
            Colors.red,
            'Sorry, an error occurred while deleting house rule',
            null,
            context);
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/searchList', (route) => false);
        });
      }
    } catch (e) {
      Message.snackMessage(Colors.red, e.toString(), null, context);
    }
    loading();
  }

  void showError(message,context){
    Message.snackMessage(Colors.red,message,null,context);
  }
}
