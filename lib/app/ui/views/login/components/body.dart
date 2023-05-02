import 'package:flutter/material.dart';
import 'package:search_and_stay/app/ui/components/circular_progress_custom.dart';

import '../../../animations/fade_animation.dart';

class Body extends StatefulWidget {
  TextEditingController userController;
  TextEditingController passwordController;
  bool obscurePassword;
  bool isLoading;
  final Function(String user, String pass,BuildContext context) validateFields;
  BuildContext context;
  Body(this.userController, this.passwordController, this.obscurePassword,
      this.isLoading, this.validateFields,this.context,
      {super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 55),
                FadeAnimation(
                    1.4,
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 3))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 0.1))),
                            child: TextField(
                              controller: widget.userController,
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.person),
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white10))),
                            child: TextField(
                              controller: widget.passwordController,
                              obscureText: widget.obscurePassword,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (widget.obscurePassword) {
                                          widget.obscurePassword = false;
                                        } else {
                                          widget.obscurePassword = true;
                                        }
                                      });
                                    },
                                    icon: Icon(widget.obscurePassword
                                        ? Icons.lock
                                        : Icons.lock_open),
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          //: Container(),
                        ],
                      ),
                    )),
                Container(),
                const SizedBox(height: 70),
                widget.isLoading == true
                    ? ShowCircularProgress(widget.isLoading)
                    : FadeAnimation(
                        1.6,
                        GestureDetector(
                          onTap: () {
                            widget.validateFields(widget.userController.text,
                                widget.passwordController.text,widget.context);
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.deepOrange),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                const SizedBox(height: 30),
                FadeAnimation(
                    1.7,
                    Center(
                      child:
                          Image.asset('images/search_and_stay.png', height: 50),
                    )),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
