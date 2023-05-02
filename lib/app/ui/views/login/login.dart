import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/header.dart';
import 'controllers/login_controller.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginController loginController;

  @override
  void initState() {
    super.initState();
    loginController = LoginController();
    loginController.getPreferences();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.deepOrange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 55),
            const Header(),
            const SizedBox(height: 10),
            Body(
                loginController.userController,
                loginController.passwordController,
                loginController.obscurePassword,
                loginController.isLoading,
                loginController.validateFields,
                context)
          ],
        ),
      ),
    );
  }
}
