import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:graphql_crud_operation/ApiProvider/ApiClient.dart';
import 'package:graphql_crud_operation/MVC/PostModule/Model/PostModel.dart';
import 'package:graphql_crud_operation/Util/Enum.dart';
import 'package:graphql_crud_operation/Util/QueryUrl.dart';

class PostController extends GetxController {
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  ApiClient apiClient = ApiClient();
  var isDataPost = false.obs;

  void postPerson() async {
    final map = Map<String, dynamic>();

    map['id'] = id.text.toString();
    map['name'] = name.text.toString();
    map['age'] = age.text.toString();
    String postQuery =
        """mutation{addPerson(id: "${id.text}", name: "${name.text}", age: ${age.text}){id name lastName age}}""";

    try {
      isDataPost(true);

      final result = await apiClient.request(
          QueryUrl.POST_URL, Method.POST, map, postQuery);

      if (result != null) {
        if (result is d.Response) {
          var data = PostModel.fromJson(result.data);

          if (data.data != null) {
            Get.snackbar("Post Data", "Data is Post Successfully",
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green);
            id.clear();
            name.clear();
            age.clear();
            isDataPost(false);
          } else {
            isDataPost(false);
          }
        }
      }
    } on Exception catch (e) {
      isDataPost(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    id.dispose();
    name.dispose();
    age.dispose();
  }
}
