class Task {
  final int taskId;
  final String taskTitle;
  final String priority;
  final String taskDescription;
  final String dueDate;
  final String projectName;

  const Task({
    required this.taskId,
    required this.taskTitle,
    required this.priority,
    required this.taskDescription,
    required this.dueDate,
    required this.projectName
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json['task_id'],
        taskTitle: json['task_title'],
        priority: json['priority'],
        taskDescription: json['task_description'],
        dueDate: json['due_date'],
        projectName: json['project_name'],
      );

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'taskTitle': taskTitle,
        'priority': priority,
        'taskDescription': taskDescription,
        'dueDate': dueDate,
        'projectName': projectName,
      };
}
