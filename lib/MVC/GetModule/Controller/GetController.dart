import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:graphql_crud_operation/ApiProvider/ApiClient.dart';
import 'package:graphql_crud_operation/MVC/GetModule/Model/GetModel.dart';
import 'package:graphql_crud_operation/Util/Enum.dart';
import 'package:graphql_crud_operation/Util/QueryUrl.dart';

class GetController extends GetxController {
  var isDataProcessing = true.obs;
  var dataList = <Person>[].obs;
  ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<GetModel?> getData() async {
    final map = Map<String, dynamic>();
    try {
      isDataProcessing(true);
      final result = await apiClient.request(
          QueryUrl.GET_QUERY_HOMEPAGE, Method.GET, map, "");
      if (result != null) {
        if (result is d.Response) {
          var data = GetModel.fromJson(result.data);
          if (data.data != null) {
            dataList(data.data!.persons);
            isDataProcessing(false);
          }
        }
      }
    } on Exception catch (e) {
      isDataProcessing(false);
    }
  }
}
