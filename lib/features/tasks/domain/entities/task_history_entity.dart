class TaskHistoryEntity {
  final String? taskId;
  final String? comment;
  final String actionType;

  final String? userId;

  final int createdAt;

  int? updatedAt;

  TaskHistoryEntity({
    required this.createdAt,
    required this.actionType,
    this.taskId,
    this.userId,
    this.comment,
  });
  // TODO
  // actionType:
  //   | 'postpone'
  //   | 'updateName'
  //   | 'doneSubtask'
  //   | 'updateSubtask'
  //   | 'stepForward'
  //   | 'leapForward'
  //   | 'setDone';
}
