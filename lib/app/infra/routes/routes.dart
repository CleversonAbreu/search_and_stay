import 'package:flutter/material.dart';
import '../../ui/views/house_rules/create/house_rules_create.dart';
import '../../ui/views/house_rules/update/house_rules_update.dart';
import '../../ui/views/house_rules/list/house_rules_list.dart';
import '../../ui/views/login/login.dart';

class RoutesCustom {
  static Route<dynamic> createRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());

      case '/searchList':
        return MaterialPageRoute(builder: (_) => HouseRulesList());

      case '/entity':
        Map? data = settings.arguments as Map?;
        return MaterialPageRoute(
            builder: (_) => HouseRulesUpdate(data!['id'], data!['image']));

      case '/insert':
        return MaterialPageRoute(
            builder: (_) => const HouseRulesCreate());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('Page not found ${settings.name}')),
                ));
    }
  }
}
