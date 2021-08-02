class PracticeQuizModel {
  String sId;
  int practiceQuesId;
  String quesText;
  List<String> options;
  String quesImgUrl;
  String solution;
  dynamic rightOption;
  String quizCategory;
  String quizSubCategory;
  String areaOfInterest;
  String creationTimeStamp;

  PracticeQuizModel(
      {this.sId,
      this.practiceQuesId,
      this.quesText,
      this.options,
      this.quesImgUrl,
      this.solution,
      this.rightOption,
      this.quizCategory,
      this.quizSubCategory,
      this.areaOfInterest,
      this.creationTimeStamp});

  PracticeQuizModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    practiceQuesId = json['practiceQuesId'];
    quesText = json['quesText'];
    options = json['options'].cast<String>();
    quesImgUrl = json['quesImgUrl'];
    solution = json['solution'];
    rightOption = json['rightOption'].toString();
    quizCategory = json['quizCategory'];
    quizSubCategory = json['quizSubCategory'];
    areaOfInterest = json['areaOfInterest'];
    creationTimeStamp = json['creationTimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['practiceQuesId'] = this.practiceQuesId;
    data['quesText'] = this.quesText;
    data['options'] = this.options;
    data['quesImgUrl'] = this.quesImgUrl;
    data['solution'] = this.solution;
    data['rightOption'] = this.rightOption.toString();
    data['quizCategory'] = this.quizCategory;
    data['quizSubCategory'] = this.quizSubCategory;
    data['areaOfInterest'] = this.areaOfInterest;
    data['creationTimeStamp'] = this.creationTimeStamp;
    return data;
  }
}
