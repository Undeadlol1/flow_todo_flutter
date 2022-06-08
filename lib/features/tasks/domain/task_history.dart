class TaskHistory {
  final String? taskId;
  final String? comment;
  final String actionType;

  final String? userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  TaskHistory({
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
