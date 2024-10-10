import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:thigiuaky/service/database.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  TextEditingController tenspController = new TextEditingController();
  TextEditingController loaispController = new TextEditingController();
  TextEditingController giaspController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.arrow_back_outlined)),
                const SizedBox(
                  width: 80.0,
                ),
                const Text(
                  "Thêm sản phẩm",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Tên sản phẩm: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: tenspController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Nhập tên sản phẩm"),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Loại sản phẩm: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: loaispController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Nhập loại sản phẩm"),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Giá sản phẩm: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: giaspController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Nhập giá sản phẩm"),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: () async {
                if (tenspController.text != "" &&
                    loaispController.text != "" &&
                    giaspController.text != "") {
                  String addID = randomAlphaNumeric(10);
                  Map<String, dynamic> thongtinsp = {
                    "tensp": tenspController.text,
                    "loaisp": loaispController.text,
                    "giasp": giaspController.text,
                  };
                  await DatabaseMethods()
                      .themsp(thongtinsp, addID)
                      .then((value) {
                        tenspController.text="";
                        loaispController.text="";
                        giaspController.text="";
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                        content: Text("Dữ liệu sản phẩm đã được cập nhật")));
                  });
                }
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Thêm",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
