import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../domain/models/goal.dart';

@lazySingleton
class CreateGoalRepository {
  final FirebaseFirestore firestore;
  const CreateGoalRepository({required this.firestore});

  Future<void> call(Goal goal) async {
    await firestore.collection('goals').doc(goal.id).set(goal.toJson());
  }
}
