import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';

class GetProfileRepository {
  final FirebaseFirestore firestore;
  const GetProfileRepository({required this.firestore});

  Future<Profile?> call({required String userId}) async {
    final profileJSON = await firestore.collection('profiles').doc(userId).get();

    log('profileJSON.id: ${profileJSON.id.toString()}');
    if (profileJSON.exists) {
      return Profile.fromJson(profileJSON.data()!);
    }

    return null;
  }
}
