import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../data/model/house_rules_model.dart';
import '../../../../../infra/services/house_rules_service.dart';
import '../../../../../utils/message.dart';

class HouseRulesCreateController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController orderController = TextEditingController();

  final TextInputType numberType = TextInputType.number;
  final TextInputType textType = TextInputType.text;

  ValueNotifier<bool> isChecked = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> progress = ValueNotifier(false);

  late int order;
  late int active;

  String nameHelperText = '';
  String orderHelperText = '';

  late FocusNode nameNode;
  late FocusNode orderNode;

  final Icon nameIcon = const Icon(Icons.edit_calendar, size: 30);
  final Icon orderIcon = const Icon(Icons.edit_calendar, size: 30);

  void loading() {
    isLoading.value = !isLoading.value;
    notifyListeners();
  }

  void toCheck(value) {
    isChecked!.value = value!;
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
        id: null,
        name: nameController.text,
        active: active,
        order: int.parse(orderController.text));
    _send(houseRulesModel!, context);
    return null;
  }

  void _send(HouseRulesModel houseRulesModel, BuildContext context) async {
    loading();
    try {
      bool insert = await HouseRulesService().insertEntity(houseRulesModel);
      if (insert) {
        Message.snackMessage(
            Colors.black26, 'House Rule inserted successfully', null, context);
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
}
