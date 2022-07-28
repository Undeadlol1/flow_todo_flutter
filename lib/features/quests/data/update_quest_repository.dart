import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/quest.dart';

class UpdateQuestRepository {
  final FirebaseFirestore firestore;
  const UpdateQuestRepository({required this.firestore});

  Future<void> call(Quest updatedQuest) async {
    return firestore
        .collection('quests')
        .doc(updatedQuest.id)
        .update(updatedQuest.toJson());
  }
}
