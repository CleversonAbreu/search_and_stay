import 'package:flutter/material.dart';

class Message{

  static snackMessage(background,text,icon,context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: background,
        content: Row(
          children: <Widget>[
            icon ?? const Icon(Icons.info_outline,color: Colors.white,),
            Text("  $text"),
          ],
        ),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }
}
