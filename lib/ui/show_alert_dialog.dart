import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<void> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  @required String defaultActionText
}) async {
  if (Platform.isIOS) {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(title),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text(defaultActionText)
          )
        ],
      )
    );
  }
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(title),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: Text(defaultActionText)
        )
      ],
    )
  );
}