import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/quest.dart';

class DeleteQuestRepository {
  final FirebaseFirestore firestore;
  const DeleteQuestRepository({required this.firestore});

  Future<void> call(Quest quest) async {
    return firestore.collection('quests').doc(quest.id).delete();
  }
}
