import 'package:flutter/material.dart';
import '../../../components/checkbox_custom.dart';
import '../../../components/constrainedbox_custom.dart';
import '../../../components/footer_custom.dart';
import '../../../components/header_custom.dart';
import 'controllers/house_rules_create_controller.dart';

class HouseRulesCreate extends StatefulWidget {
  const HouseRulesCreate({super.key});
  @override
  State createState() => _HouseRulesCreateState();
}

class _HouseRulesCreateState extends State<HouseRulesCreate> {
  late HouseRulesCreateController houseRulesCreateController;

  @override
  void initState() {
    super.initState();
    houseRulesCreateController = HouseRulesCreateController();
    houseRulesCreateController.addListener(() {
      setState(() {});
    });
    houseRulesCreateController.nameNode = FocusNode();
    houseRulesCreateController.orderNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    houseRulesCreateController.nameNode.dispose();
    houseRulesCreateController.orderNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'New House Rule',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 1),
          child: Column(
            children: <Widget>[
              Header(
                  'House Rules',
                  'Register here your house rule quickly and easily.',
                  houseRulesCreateController.nameIcon),
              ConstrainedBoxCustom(
                  houseRulesCreateController.nameController,
                  'Name',
                  houseRulesCreateController.nameNode,
                  0,
                  null,
                  null,
                  houseRulesCreateController.nameIcon,
                  houseRulesCreateController.textType,
                  houseRulesCreateController.nameHelperText,
                  false),
              ConstrainedBoxCustom(
                  houseRulesCreateController.orderController,
                  'Order',
                  houseRulesCreateController.orderNode,
                  0,
                  null,
                  null,
                  houseRulesCreateController.orderIcon,
                  houseRulesCreateController.numberType,
                  houseRulesCreateController.orderHelperText,
                  false),
              CheckboxCustom(houseRulesCreateController!.isChecked,
                  houseRulesCreateController!.toCheck,false),
              Footer(houseRulesCreateController.validateFields, 'Add', null,
                  null, houseRulesCreateController.isLoading, context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
