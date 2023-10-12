library app_bar_modif;

import 'package:flutter/material.dart';
import 'package:posyandu_apps/config/app_color.dart';

class AppBarModif {
  static PreferredSizeWidget appBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      toolbarHeight: 70,
      leading: BackButton(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  static PreferredSizeWidget appBarAdd(String title, Widget actions) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      toolbarHeight: 70,
      leading: BackButton(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [actions],
    );
  }
}
