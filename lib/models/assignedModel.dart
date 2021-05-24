class AssignedQuiz {
  String sId;
  int quizId;
  int quizMasterId;
  String quizTitle;
  String quizCategory;
  String quizSubCategory;
  String areaOfInterest;
  String startDate;
  String startTime;
  String endDate;
  String slot;
  String availableSlots;
  String endTime;
  int noOfQuestions;
  String difficultyLevel;
  int timePerQues;
  int entryAmount;
  int winningPrize;
  int bookingStatus;
  List<PrizePool> prizePool;
  List<Questions> questions;
  List<int> access;
  String creationTimeStamp;

  AssignedQuiz(
      {this.sId,
      this.quizId,
      this.slot,
      this.bookingStatus,
      this.availableSlots,
      this.quizMasterId,
      this.quizTitle,
      this.quizCategory,
      this.quizSubCategory,
      this.areaOfInterest,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.noOfQuestions,
      this.difficultyLevel,
      this.timePerQues,
      this.entryAmount,
      this.winningPrize,
      this.prizePool,
      this.questions,
      this.access,
      this.creationTimeStamp});

  AssignedQuiz.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quizId = json['quizId'];
    slot = json['slot'].toString();
    bookingStatus = json['bookingStatus'];
    availableSlots = json['availableSlots'].toString();
    quizMasterId = json['quizMasterId'];
    quizTitle = json['quizTitle'];
    quizCategory = json['quizCategory'];
    quizSubCategory = json['quizSubCategory'];
    areaOfInterest = json['areaOfInterest'];
    startDate = json['startDate'].toString();
    startTime = json['startTime'];
    endDate = json['endDate'].toString();
    endTime = json['endTime'];
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
    access = json['access'].cast<int>();
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
    data['access'] = this.access;
    data['creationTimeStamp'] = this.creationTimeStamp;
    return data;
  }
}

class PrizePool {
  int rankNo;
  String prize;

  PrizePool({this.rankNo, this.prize});

  PrizePool.fromJson(Map<String, dynamic> json) {
    rankNo = json['rankNo'];
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
  int questionId;
  String quesText;
  List<String> options;
  String quesImgUrl;
  String solution;
  int rightOption;
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
