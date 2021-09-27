import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_crud_operation/MVC/GetModule/Controller/GetController.dart';
import 'package:graphql_crud_operation/MVC/PostModule/Views/PostPage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GetController _gc = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GraphQL GetData Using DIO"),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.to(() => PostPage());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.blue),
            child: Center(
              child: Text("Go to Post Page",
                  style: TextStyle(
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                      fontFamily: "CircularStd",
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _gc.getData();
        },
        child: Container(
          width: Get.width,
          height: Get.height / 1.2,
          child: Obx(
            () => _gc.isDataProcessing.value == true
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _gc.dataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_gc.dataList[index].name.toString()),
                        subtitle: Text(_gc.dataList[index].lastName.toString()),
                        leading: Text(_gc.dataList[index].id.toString()),
                        trailing: Text(_gc.dataList[index].age.toString()),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
