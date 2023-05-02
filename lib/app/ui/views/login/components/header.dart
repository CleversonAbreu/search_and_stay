
import 'package:flutter/material.dart';

import '../../../animations/fade_animation.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  <Widget>[
          FadeAnimation(
              3,
              Center(
                child: Image.asset('images/logo.png',height: 175,),
              )
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
