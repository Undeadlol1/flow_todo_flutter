import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/quest.dart';

class CreateQuestRepository {
  final FirebaseFirestore firestore;
  const CreateQuestRepository({required this.firestore});

  Future<void> call(Quest quest) async {
    await firestore.collection('quests').doc(quest.id).set(quest.toJson());
  }
}
