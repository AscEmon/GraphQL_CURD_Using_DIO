import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_crud_operation/MVC/PostModule/Controller/PostController.dart';

class PostPage extends StatelessWidget {
  PostPage({Key? key}) : super(key: key);
  final PostController _pc = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GraphQL POST Data Using DIO"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                maxLines: 1,
                controller: _pc.id,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Enter Id",
                  filled: true,
                  counterText: "",
                  fillColor: Color(0xfff2f2f2),
                  hintStyle: TextStyle(
                      color: Color(0xff808080),
                      fontWeight: FontWeight.w400,
                      fontFamily: "CircularStd",
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                maxLines: 1,
                controller: _pc.name,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  filled: true,
                  counterText: "",
                  fillColor: Color(0xfff2f2f2),
                  hintStyle: TextStyle(
                      color: Color(0xff808080),
                      fontWeight: FontWeight.w400,
                      fontFamily: "CircularStd",
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                maxLines: 1,
                controller: _pc.age,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Enter Your Age",
                  filled: true,
                  counterText: "",
                  fillColor: Color(0xfff2f2f2),
                  hintStyle: TextStyle(
                      color: Color(0xff808080),
                      fontWeight: FontWeight.w400,
                      fontFamily: "CircularStd",
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                _pc.postPerson();
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
                    child: Obx(
                      () => _pc.isDataPost.value == true
                          ? Center(
                              child: Text("Loading...",
                                  style: TextStyle(
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "CircularStd",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                  textAlign: TextAlign.center))
                          : Text("Post Data",
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
            ),
          ],
        ),
      ),
    );
  }
}
