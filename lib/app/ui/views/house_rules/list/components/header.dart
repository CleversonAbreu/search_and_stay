import 'package:flutter/material.dart';
import '../../../../../data/sources/cache/logged_user.dart';

class Header extends StatelessWidget {
  LoggedUser? loggedUser;
  Header(this.loggedUser, {super.key});

  @override
  Widget build(BuildContext context) {
    _clearPreferences() async {
      loggedUser!.active = false;
      await LoggedUser().clearPreferences();
    }

    void _setUrl() async {
      if (loggedUser!.active) {
        _clearPreferences();
        Navigator.pushNamedAndRemoveUntil(context, '/searchList', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.deepOrangeAccent,
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Center(
                child: Text(
              "house rules",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
          ),
        ),
        Container(),
        Positioned(
          top: 100.0,
          left: 20.0,
          right: 20.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
                child:
                    Center(child: Image.asset('images/logo.png', height: 90))),
            primary: false,
            title: const Center(
              child: Text('Search and Stay',
                  style: TextStyle(color: Colors.black26)),
            ),
            actions: <Widget>[
              GestureDetector(
                onLongPress: () {},
                onTap: () {},
                child: PopupMenuButton<int>(
                  onSelected: (result) async {_setUrl();},
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        loggedUser!.active == true ? "SignOut" : 'SignIn',
                      ),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
