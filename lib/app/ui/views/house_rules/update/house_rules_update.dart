import 'package:flutter/material.dart';
import 'package:search_and_stay/app/ui/views/house_rules/update/controllers/house_rules_update_controller.dart';
import '../../../components/checkbox_custom.dart';
import '../../../components/constrainedbox_custom.dart';
import '../../../components/footer_custom.dart';
import '../../../components/header_custom.dart';

class HouseRulesUpdate extends StatefulWidget {
  int id;
  String image;
  HouseRulesUpdate(this.id, this.image, {super.key});
  @override
  _HouseRulesUpdateState createState() => _HouseRulesUpdateState();
}

class _HouseRulesUpdateState extends State<HouseRulesUpdate> {
  HouseRulesUpdateController? houseRulesUpdateController;

  @override
  void initState() {
    super.initState();
    houseRulesUpdateController = HouseRulesUpdateController();
    houseRulesUpdateController?.getPreferences();
    try {
      houseRulesUpdateController?.getEntity(widget.id, context);
    } catch (error) {
      houseRulesUpdateController?.showError(error, context);
    }

    houseRulesUpdateController?.idNode = FocusNode();
    houseRulesUpdateController?.nameNode = FocusNode();
    houseRulesUpdateController?.orderNode = FocusNode();
    houseRulesUpdateController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    houseRulesUpdateController?.idNode.dispose();
    houseRulesUpdateController?.nameNode.dispose();
    houseRulesUpdateController?.orderNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          houseRulesUpdateController!.show == true
              ? 'Edit House Rule'
              : 'Consult House Rule',
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
                  houseRulesUpdateController!.show == true
                      ? 'Register here your house rule quickly and easily.'
                      : 'Consult here your house rule quickly and easily.',
                  houseRulesUpdateController!.orderIcon),
              ConstrainedBoxCustom(
                  houseRulesUpdateController!.idController,
                  'Id',
                  houseRulesUpdateController!.idNode,
                  0,
                  null,
                  null,
                  houseRulesUpdateController!.orderIcon,
                  houseRulesUpdateController!.textType,
                  houseRulesUpdateController!.idHelperText,
                  true,
                  null,
                  true,
                  true,
                  false),
              ConstrainedBoxCustom(
                  houseRulesUpdateController!.nameController,
                  'Name',
                  houseRulesUpdateController!.nameNode,
                  0,
                  null,
                  null,
                  houseRulesUpdateController!.orderIcon,
                  houseRulesUpdateController!.textType,
                  houseRulesUpdateController!.nameHelperText,
                  false,
                  null,
                  true,
                  true,
                  houseRulesUpdateController!.show == true ? true : false),
              ConstrainedBoxCustom(
                  houseRulesUpdateController!.orderController,
                  'Order',
                  houseRulesUpdateController!.orderNode,
                  0,
                  null,
                  null,
                  houseRulesUpdateController!.orderIcon,
                  houseRulesUpdateController!.numberType,
                  houseRulesUpdateController!.orderHelperText,
                  false,
                  null,
                  true,
                  true,
                  houseRulesUpdateController!.show == true ? true : false),
              CheckboxCustom(
                  houseRulesUpdateController!.isChecked,
                  houseRulesUpdateController!.toCheck,
                  houseRulesUpdateController!.show == true ? false : true),
              houseRulesUpdateController!.show == true
                  ? Footer(houseRulesUpdateController!.validateFields, 'Edit',
                      null, null, houseRulesUpdateController!.isLoading)
                  : Container(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
