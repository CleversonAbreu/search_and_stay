import 'package:flutter/material.dart';
import '../../../../data/model/house_rules_model.dart';
import '../../../../infra/services/house_rules_service.dart';
import '../list/components/header.dart';
import 'controllers/house_rules_list_controller.dart';

class HouseRulesList extends StatefulWidget {
  @override
  _HouseRulesListState createState() => _HouseRulesListState();
}

class _HouseRulesListState extends State<HouseRulesList> {
  HouseRulesListController? houseRulesListController;
  late HouseRulesService houseRulesService;
  late HouseRulesModel houseRulesModel;
  late final ScrollController _scrollController;
  final loading = ValueNotifier(true);
  bool progress = false;
  bool? show = false;

  loadHouseRules() async {
    setState(() {
      progress = !progress;
    });
    try{
      await houseRulesService.getEntities();
    }catch(error){
      houseRulesListController!.showError(error,context);
    }
    setState(() {
      progress = !progress;
    });
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        loading.value) {
      loadHouseRules();
    }
  }

  @override
  void initState() {
    super.initState();
    houseRulesListController = HouseRulesListController();
    houseRulesListController!.getPreferences();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    houseRulesService = HouseRulesService();
    loadHouseRules();
    houseRulesListController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Header(houseRulesListController!.loggedUser),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: AnimatedBuilder(
        animation: houseRulesService,
        builder: (context, snapshot) {
          return Stack(
            children: [
              ListView.separated(
                  controller: _scrollController,
                  itemBuilder: ((context, index) {

                    final houseRule = houseRulesService.houseRulesModel[index];
                    return GestureDetector(
                      child: Dismissible(
                        key: Key(houseRule.id.toString()),
                        onDismissed: (direction) {
                          if (houseRulesListController!.show == true) {
                            houseRulesListController!
                                .delete(houseRule.id.toString(), context);
                          } else {
                            houseRulesListController!.noDelete(context);
                          }
                        },
                        child: Column(
                          children: [
                            ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset('images/no_image_icon.png'),
                              ),
                              title:
                                  Text('${houseRule.id} - ${houseRule.name}'),
                              subtitle: Text(
                                  houseRule.active == 1 ? 'Active' : 'Inactive',
                                  style: const TextStyle(fontSize: 12)),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: houseRulesListController!
                                              .loggedUser!.active ==
                                          true
                                      ? <Widget>[
                                          const Icon(Icons.keyboard_arrow_left),
                                          const Icon(Icons.delete),
                                        ]
                                      : <Widget>[]),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/entity', arguments: {
                          'id': houseRule.id,
                          'image': 'images/no_image_icon.png'
                        });
                      },
                    );
                  }),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: houseRulesService.houseRulesModel.length),
              progress == true
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
            ],
          );
        },
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
