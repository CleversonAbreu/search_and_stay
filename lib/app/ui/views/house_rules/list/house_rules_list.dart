import 'package:flutter/material.dart';
import 'package:search_and_stay/app/ui/views/house_rules/list/components/body.dart';
import '../../../../infra/services/house_rules_service.dart';
import '../list/components/header.dart';
import 'controllers/house_rules_list_controller.dart';

class HouseRulesList extends StatefulWidget {
  @override
  _HouseRulesListState createState() => _HouseRulesListState();
}

class _HouseRulesListState extends State<HouseRulesList> {
  late HouseRulesListController houseRulesListController;

  @override
  void initState() {
    super.initState();
    houseRulesListController = HouseRulesListController();
    houseRulesListController!.getPreferences();
    houseRulesListController.scrollController = ScrollController();
    houseRulesListController.scrollController.addListener(houseRulesListController.infiniteScrolling);
    houseRulesListController.houseRulesService = HouseRulesService();
    houseRulesListController.loadHouseRules();
    houseRulesListController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    houseRulesListController.scrollController.dispose();
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Header(houseRulesListController!.loggedUser),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body:
      Body(houseRulesService: houseRulesListController.houseRulesService,
          scrollController: houseRulesListController.scrollController,
      houseRulesListController: houseRulesListController,
          progress: houseRulesListController.progress
      ),
      floatingActionButton: houseRulesListController!.show == true
          ? FloatingActionButton(
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: () => Navigator.pushNamed(context, '/insert'),
              child: const Icon(Icons.add))
          : Container(),
    );
  }
}
