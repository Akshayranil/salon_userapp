import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/features/home/data/model/service_model.dart';
import 'package:salon_app/features/home/data/model/staff_model.dart';

class ServiceUserRemoteDataSource {
  final FirebaseFirestore firestore;

  ServiceUserRemoteDataSource(this.firestore);

  Future<List<ServiceModel>> getServices() async {
    final snapshot = await firestore.collection("services").get();
    return snapshot.docs
        .map((e) => ServiceModel.fromJson(e.data()))
        .toList();
  }

  Future<List<StaffModel>> getStaffByService(String serviceId) async {
    final snapshot = await firestore.collection("staff").get();

    return snapshot.docs
        .map((e) => StaffModel.fromJson(e.data()))
        .where((staff) => staff.serviceIds.contains(serviceId))
        .toList();
  }
}