import 'package:flutter/material.dart';
import 'dart:io';

class Header extends StatelessWidget {
  String title;
  String text;
  Icon icon;
  Color? colorText;
  String? img;
  final File? selfie;

  Header(this.title, this.text, this.icon,
      [this.colorText, this.img, this.selfie]);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 0, right: 8, bottom: 8),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            selfie == null
                ? CircleAvatar(
                    radius: this.img == null ? 90 : 120,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                        child: SizedBox(
                      width: this.img == null ? 150 : null,
                      height: this.img == null ? 170 : null,
                      child:
                           Image.asset(
                              'images/no_image_icon.png',
                              height: 10,
                            ),
                    )),
                  )
                : Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                          bottomLeft: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0),
                        ),
                        border: Border.all(color: Colors.white10)),
                    child: SizedBox(
                      child: Image.file(selfie!),
                    ),
                  )
          ],
        ),
      ),
      SizedBox(
        width: 259,
        child: Column(children: [
          Center(
            child: Text(
              '\n ${this.title} \n',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      colorText != null ? colorText : Colors.black54),
            ),
          ),
          selfie == null ?
          Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Center(
                child: Text(text,
                    style: TextStyle(
                        color: this.colorText != null
                            ? this.colorText
                            : Colors.black54)),
              ))
          : Container(),
        ]),
      )
    ]));
  }
}
