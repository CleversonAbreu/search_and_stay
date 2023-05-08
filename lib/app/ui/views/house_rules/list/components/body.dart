import 'package:flutter/material.dart';
import '../../../../../infra/services/house_rules_service.dart';
import '../controllers/house_rules_list_controller.dart';

class Body extends StatelessWidget {
  late HouseRulesService houseRulesService;
  final ScrollController scrollController;
  ValueNotifier<bool> progress;
  //bool? progress;
  HouseRulesListController houseRulesListController;

  Body({ required this.houseRulesService,required this.scrollController,required this.progress,required this.houseRulesListController});

  @override
  Widget build(BuildContext context) {
    return  AnimatedBuilder(
      animation: houseRulesService,
      builder: (context, snapshot) {
        return Stack(
          children: [
            ListView.separated(
                controller: scrollController,
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
            //progress == true
             progress.value == true
                ? const Center(child: CircularProgressIndicator())
                : Container()
          ],
        );
      },
    );
  }
}
