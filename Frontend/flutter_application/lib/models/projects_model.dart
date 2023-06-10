class Project {
  final int projectId;
  final String projectName;
  final String projectType;
  final String projectStatus;
  final String projectAdd;
  final String dueDate;
  final int userId;

  const Project(
      {required this.projectId,
      required this.projectName,
      required this.projectType,
      required this.projectStatus,
      required this.projectAdd,
      required this.dueDate,
      required this.userId});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectId: json['project_id'],
        projectName: json['project_name'],
        projectType: json['project_type'],
        projectStatus: json['project_status'],
        projectAdd: json['project_add'],
        dueDate: json['due_date'],
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'projectName': projectName,
        'projectType': projectType,
        'projectStatus': projectStatus,
        'projectAdd': projectAdd,
        'dueDate': dueDate,
        'userId': userId,
      };
}
