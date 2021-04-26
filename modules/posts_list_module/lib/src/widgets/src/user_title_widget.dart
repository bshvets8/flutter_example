import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTitleWidget extends StatelessWidget {
  final String username;

  const UserTitleWidget({Key key, @required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(29)), color: Colors.black12),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 16),
          child: Row(
            children: [
              _buildIcon(context, username),
              SizedBox(
                width: 8,
              ),
              Text(
                username,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, String userName) {
    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      child: Text(
        userName[0].toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
    );
  }
}
