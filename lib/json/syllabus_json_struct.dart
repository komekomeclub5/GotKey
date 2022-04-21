class SyllabusStruct {
  List<Syllabus>? syllabus;

  SyllabusStruct({this.syllabus});

  SyllabusStruct.fromJson(Map<String, dynamic> json) {
    if (json['syllabus'] != "none") {
      syllabus = <Syllabus>[];
      json['syllabus'].forEach((v) {
        syllabus!.add(Syllabus.fromJson(v));
      });
    }
  }

  get courseTitle => null;
}

class Syllabus {
  String? title;
  String? folder;
  String? courseTitle;
  String? classroom;
  String? teacher;
  String? targetGrade;
  String? semester;
  String? weekdayPeriod;
  String? courseClassification;
  String? creditClassification;
  String? creditTypeOtherInformation;
  String? typeClass;
  String? credits;
  String? precautions;
  String? additionalInformation;
  String? contactAboutClass;
  String? policyAndRelevance;
  String? aimLecture;
  String? forStudents;
  String? courseGoals;
  String? courseSchedule;
  List<String>? theme;
  List<String>? homework;
  String? references;
  String? meansOfLearning;
  String? evaluation;
  String? relatedSubjects;

  Syllabus.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    folder = json['folder'];
    courseTitle = json['courseTitle'];
    classroom = json['classroom'];
    teacher = json['teacher'];
    targetGrade = json['targetGrade'];
    semester = json['semester'];
    weekdayPeriod = json['weekdayPeriod'];
    courseClassification = json['courseClassification'];
    creditClassification = json['creditClassification'];
    creditTypeOtherInformation = json['creditTypeOtherInformation'];
    typeClass = json['typeClass'];
    credits = json['credits'];
    precautions = json['precautions'];
    additionalInformation = json['additionalInformation'];
    contactAboutClass = json['contactAboutClass'];
    policyAndRelevance = json['policyAndRelevance'];
    aimLecture = json['aimLecture'];
    forStudents = json['forStudents'];
    courseGoals = json['courseGoals'];
    courseSchedule = json['courseSchedule'];
    theme = json['theme'].cast<String>();
    homework = json['homework'].cast<String>();
    references = json['references'];
    meansOfLearning = json['meansOfLearning'];
    evaluation = json['evaluation'];
    relatedSubjects = json['relatedSubjects'];
  }
}
