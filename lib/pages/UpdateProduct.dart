import 'package:flutter/material.dart';
import 'package:thigiuaky/service/database.dart';

class UpdateProduct extends StatefulWidget {
  final String productId;
  final String tensp;
  final String loaisp;
  final String giasp;

  const UpdateProduct(
      {required this.productId,
        required this.tensp,
        required this.loaisp,
        required this.giasp});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  late TextEditingController tenspController;
  late TextEditingController loaispController;
  late TextEditingController giaspController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the current product details
    tenspController = TextEditingController(text: widget.tensp);
    loaispController = TextEditingController(text: widget.loaisp);
    giaspController = TextEditingController(text: widget.giasp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Matching the header style of "Thêm sản phẩm"
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_outlined),
                ),
                const SizedBox(
                  width: 80.0,
                ),
                const Text(
                  "Cập nhật sản phẩm",  // Update the title to "Cập nhật sản phẩm"
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
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
            const SizedBox(height: 30.0),
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
            const SizedBox(height: 30.0),
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
            const SizedBox(height: 40.0),
            GestureDetector(
              onTap: () async {
                if (tenspController.text != "" &&
                    loaispController.text != "" &&
                    giaspController.text != "") {
                  Map<String, dynamic> updatedProduct = {
                    "tensp": tenspController.text,
                    "loaisp": loaispController.text,
                    "giasp": giaspController.text,
                  };

                  await DatabaseMethods()
                      .CapNhatSanpham(widget.productId, updatedProduct)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Cập nhật sản phẩm thành công"),
                    ));
                    Navigator.pop(context);  // Go back to the previous screen
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
                      "Cập nhật",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500),
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
