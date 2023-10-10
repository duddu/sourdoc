import 'package:flutter/material.dart';

MaterialApp getWidgetWithTestScaffold(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: Column(children: <Row>[
        Row(children: <Widget>[widget])
      ]),
    ),
  );
}
