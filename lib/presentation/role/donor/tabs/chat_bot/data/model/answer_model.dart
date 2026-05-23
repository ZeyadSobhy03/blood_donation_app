/// answer : "التبرع بالدم هو عملية تطوعية يقوم فيها شخص سليم بالتبرع بدمه لمساعدة المرضى المحتاجين. أهلاً بك!"

class AnswerModel {
  AnswerModel({
      this.answer,});

  AnswerModel.fromJson(dynamic json) {
    answer = json['answer'];
  }
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = answer;
    return map;
  }

}