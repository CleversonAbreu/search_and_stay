import 'package:flutter/material.dart';

import 'app/infra/routes/routes.dart';
import 'app/ui/views/house_rules/list/house_rules_list.dart';
import 'app/ui/views/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search and Stay',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HouseRulesList(),
      initialRoute: '/',
      onGenerateRoute: RoutesCustom.createRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
