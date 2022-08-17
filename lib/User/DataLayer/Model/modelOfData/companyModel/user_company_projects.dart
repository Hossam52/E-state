import 'dart:convert';

import 'package:osol/Company/dataLayer/dataModel/projectsOfCompany/ProjectsofCompany.dart';

class UserCompanyProjects {
  bool status;
  Projects projects;
  UserCompanyProjects({
    required this.status,
    required this.projects,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'projects': projects.toJson(),
    };
  }

  factory UserCompanyProjects.fromMap(Map<String, dynamic> map) {
    return UserCompanyProjects(
      status: map['status'] ?? false,
      projects: Projects.fromJson(map['projects']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCompanyProjects.fromJson(String source) =>
      UserCompanyProjects.fromMap(json.decode(source));
}
