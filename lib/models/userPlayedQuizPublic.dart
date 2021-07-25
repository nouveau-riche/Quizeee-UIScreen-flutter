class UserPlayedQuizPublic {
  String sId;
  dynamic quizId;
  dynamic quizMasterId;
  String quizTitle;
  String quizCategory;
  String quizSubCategory;
  String areaOfInterest;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  dynamic slots;
  dynamic availableSlots;
  dynamic noOfQuestions;
  String difficultyLevel;
  dynamic timePerQues;
  dynamic entryAmount;
  dynamic winningPrize;
  List<PrizePool> prizePool;
  List<Questions> questions;
  Age age;
  String creationTimeStamp;
  dynamic startDateNew;
  UserPlayedQuizPublic(
      {this.sId,
      this.quizId,
      this.quizMasterId,
      this.startDateNew,
      this.quizTitle,
      this.quizCategory,
      this.quizSubCategory,
      this.areaOfInterest,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.slots,
      this.availableSlots,
      this.noOfQuestions,
      this.difficultyLevel,
      this.timePerQues,
      this.entryAmount,
      this.winningPrize,
      this.prizePool,
      this.questions,
      this.age,
      this.creationTimeStamp});

  UserPlayedQuizPublic.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quizId = json['quizId'];
    startDateNew = json['startDate_new'];
    quizMasterId = json['quizMasterId'];
    quizTitle = json['quizTitle'];
    quizCategory = json['quizCategory'];
    quizSubCategory = json['quizSubCategory'];
    areaOfInterest = json['areaOfInterest'];
    startDate = json['startDate'].toString();
    startTime = json['startTime'];
    endDate = json['endDate'].toString();
    endTime = json['endTime'];
    slots = json['slots'];
    availableSlots = json['availableSlots'];
    noOfQuestions = json['noOfQuestions'];
    difficultyLevel = json['difficultyLevel'];
    timePerQues = json['timePerQues'];
    entryAmount = json['entryAmount'];
    winningPrize = json['winningPrize'];
    if (json['prizePool'] != null) {
      prizePool = new List<PrizePool>();
      json['prizePool'].forEach((v) {
        prizePool.add(new PrizePool.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
    age = json['age'] != null ? new Age.fromJson(json['age']) : null;
    creationTimeStamp = json['creationTimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quizId'] = this.quizId;
    data['quizMasterId'] = this.quizMasterId;
    data['quizTitle'] = this.quizTitle;
    data['quizCategory'] = this.quizCategory;
    data['quizSubCategory'] = this.quizSubCategory;
    data['areaOfInterest'] = this.areaOfInterest;
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    data['endDate'] = this.endDate;
    data['endTime'] = this.endTime;
    data['slots'] = this.slots;
    data['availableSlots'] = this.availableSlots;
    data['noOfQuestions'] = this.noOfQuestions;
    data['difficultyLevel'] = this.difficultyLevel;
    data['timePerQues'] = this.timePerQues;
    data['entryAmount'] = this.entryAmount;
    data['winningPrize'] = this.winningPrize;
    if (this.prizePool != null) {
      data['prizePool'] = this.prizePool.map((v) => v.toJson()).toList();
    }
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    if (this.age != null) {
      data['age'] = this.age.toJson();
    }
    data['creationTimeStamp'] = this.creationTimeStamp;
    return data;
  }
}

class PrizePool {
  String rankNo;
  dynamic prize;

  PrizePool({this.rankNo, this.prize});

  PrizePool.fromJson(Map<String, dynamic> json) {
    rankNo = json['rankNo'].toString();
    prize = json['prize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rankNo'] = this.rankNo;
    data['prize'] = this.prize;
    return data;
  }
}

class Questions {
  dynamic questionId;
  String quesText;
  List<String> options;
  String quesImgUrl;
  String solution;
  dynamic rightOption;
  String quizCategory;
  String quizSubCategory;
  String areaOfInterest;

  Questions(
      {this.questionId,
      this.quesText,
      this.options,
      this.quesImgUrl,
      this.solution,
      this.rightOption,
      this.quizCategory,
      this.quizSubCategory,
      this.areaOfInterest});

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    quesText = json['quesText'];
    options = json['options'].cast<String>();
    quesImgUrl = json['quesImgUrl'];
    solution = json['solution'];
    rightOption = json['rightOption'];
    quizCategory = json['quizCategory'];
    quizSubCategory = json['quizSubCategory'];
    areaOfInterest = json['areaOfInterest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['quesText'] = this.quesText;
    data['options'] = this.options;
    data['quesImgUrl'] = this.quesImgUrl;
    data['solution'] = this.solution;
    data['rightOption'] = this.rightOption;
    data['quizCategory'] = this.quizCategory;
    data['quizSubCategory'] = this.quizSubCategory;
    data['areaOfInterest'] = this.areaOfInterest;
    return data;
  }
}

class Age {
  dynamic start;
  dynamic end;

  Age({this.start, this.end});

  Age.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
