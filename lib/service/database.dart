import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future themsp(Map<String, dynamic> thongtinsp, String id) async {
    return await FirebaseFirestore.instance
        .collection("Sanpham")
        .doc(id)
        .set(thongtinsp);
  }

  Future<Stream<QuerySnapshot>> getSanphamDetails() async {
    return await FirebaseFirestore.instance.collection("Sanpham").snapshots();
  }

  XoaSanpham(String id) async {
    return await FirebaseFirestore.instance
        .collection("Sanpham")
        .doc(id)
        .delete();
  }

  Future<void> CapNhatSanpham(String id, Map<String, dynamic> productData) async {
    return await FirebaseFirestore.instance
        .collection("Sanpham")
        .doc(id)
        .update(productData);
  }
}
