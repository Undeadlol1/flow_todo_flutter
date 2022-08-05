import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';

class UpsertProfileRepository {
  final FirebaseFirestore firestore;
  const UpsertProfileRepository({required this.firestore});

  Future<void> call(Profile updatedProfile) async {
    return firestore
        .collection('profiles')
        .withConverter<Profile>(
          toFirestore: (document, _) => document.toJson(),
          fromFirestore: (snapshot, _) => Profile.fromJson(snapshot.data()!),
        )
        .doc(updatedProfile.id)
        .set(updatedProfile, SetOptions(merge: true));
  }
}
