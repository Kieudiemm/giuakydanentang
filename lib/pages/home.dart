import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thigiuaky/pages/AddProduct.dart';
import 'package:thigiuaky/service/database.dart';

import 'UpdateProduct.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void initState(){
    getontheload();
    super.initState();
  }
  getontheload()async{
    sanphamStream = await DatabaseMethods().getSanphamDetails();
    setState(() {

    });
  }

  Stream? sanphamStream;

  Widget danhsachsanpham() {
    return StreamBuilder(
        stream: sanphamStream,
        builder: (context, AsyncSnapshot snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshots.hasData || snapshots.data.docs.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshots.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot ds = snapshots.data.docs[index];

              // Ensure ds.data() is not null before checking for fields
              Map<String, dynamic>? data = ds.data() as Map<String, dynamic>?;

              String tensp = data != null && data.containsKey('tensp') ? data['tensp'] : 'N/A';
              String loaisp = data != null && data.containsKey('loaisp') ? data['loaisp'] : 'N/A';
              String giasp = data != null && data.containsKey('giasp') ? data['giasp'].toString() : 'N/A';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tên sản phẩm: $tensp",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              // Delete Icon with better spacing and design
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseMethods().XoaSanpham(ds.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.withOpacity(0.2),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Edit Icon with better spacing and design
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProduct(
                                        productId: ds.id,
                                        tensp: tensp,
                                        loaisp: loaisp,
                                        giasp: giasp,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withOpacity(0.2),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Loại sản phẩm: $loaisp",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Giá sản phẩm: $giasp VND",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addproduct()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Danh sách sản phẩm",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 30.0),
            Expanded(child: danhsachsanpham()),
          ],
        ),
      ),
    );
  }
}
