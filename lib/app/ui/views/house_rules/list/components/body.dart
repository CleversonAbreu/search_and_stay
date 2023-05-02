import 'package:flutter/material.dart';
import '../../../../../data/sources/cache/logged_user.dart';
import '../../../../../infra/services/house_rules_service.dart';

class Body extends StatelessWidget {
  LoggedUser  loggedUser = LoggedUser();
  final Function(String id) delete;
  Body(this.loggedUser, this.delete, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: HouseRulesService().getEntities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString().toLowerCase()));
          } else if (snapshot.hasData) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(children: [
                  GestureDetector(
                    child: Dismissible(
                      key: Key(snapshot.data![index].id.toString()),
                      onDismissed: (direction) {
                        if(loggedUser.active == true)
                            delete(snapshot.data![index].id.toString());
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('${snapshot.data![index].id} - ' +
                                snapshot.data?[index].name),
                            subtitle: Text(
                                snapshot.data?[index].active == 1
                                    ? 'Active'
                                    : 'Inactive',
                                style: const TextStyle(fontSize: 12)),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: loggedUser.active == true
                                    ? <Widget>[
                                        const Icon(Icons.keyboard_arrow_left),
                                        const Icon(Icons.delete),
                                      ]
                                    : <Widget>[]),
                            leading: const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('images/no_image_icon.png'),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            indent: 39,
                            endIndent: 28,
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/entity', arguments: {
                        'id': snapshot.data?[index].id,
                        'image': 'images/no_image_icon.png'
                      });
                    },
                  ),
                ]);
              },
              separatorBuilder: (context, index) => const Divider(
                height: 0.5,
                color: Colors.white,
              ),
              itemCount: snapshot.data!.length,
            );
          }
        }
        return Container();
      },
    );
  }
}
