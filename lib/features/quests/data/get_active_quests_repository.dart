import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/quest.dart';
import 'package:flutter/foundation.dart';

class GetActiveQuestsRepository {
  final FirebaseFirestore firestore;
  const GetActiveQuestsRepository({required this.firestore});

  Future<List<Quest>> call({required String userId}) async {
    final questsSnapshot = await firestore
        .collection('quests')
        .where('userId', isEqualTo: userId)
        .where('isActive', isEqualTo: false)
        .limit(250)
        .get();

    final listOfJsons = questsSnapshot.docs.map((e) => e.data()).toList();

    return compute(_parseListOfJsons, listOfJsons);
  }
}

List<Quest> _parseListOfJsons(List<Map<String, dynamic>> docs) {
  return docs.map(Quest.fromJson).toList();
}
