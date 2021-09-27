import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_crud_operation/MVC/GetModule/View/HomePage.dart';

main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GraphQL CRUD Operation using DIO',
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'CircularStd',
      ),
    );
  }
}
