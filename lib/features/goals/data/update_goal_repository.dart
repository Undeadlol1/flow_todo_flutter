import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../domain/models/goal.dart';

@lazySingleton
class UpdateGoalRepository {
  final FirebaseFirestore firestore;
  const UpdateGoalRepository({required this.firestore});

  Future<void> call(Goal updatedGoal) {
    return firestore
        .collection('goals')
        .doc(updatedGoal.id)
        .update(updatedGoal.toJson());
  }
}
