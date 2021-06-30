class UserRank {
  int resultId;
  int userId;
  int score;
  int responseTime;
  List<ReviewSolutions> reviewSolutions;
  int rank;

  UserRank(
      {this.resultId,
      this.userId,
      this.score,
      this.responseTime,
      this.reviewSolutions,
      this.rank});

  UserRank.fromJson(Map<String, dynamic> json) {
    resultId = json['resultId'];
    userId = json['userId'];
    score = json['score'];
    responseTime = json['responseTime'];
    if (json['reviewSolutions'] != null) {
      reviewSolutions = new List<ReviewSolutions>();
      json['reviewSolutions'].forEach((v) {
        reviewSolutions.add(new ReviewSolutions.fromJson(v));
      });
    }
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultId'] = this.resultId;
    data['userId'] = this.userId;
    data['score'] = this.score;
    data['responseTime'] = this.responseTime;
    if (this.reviewSolutions != null) {
      data['reviewSolutions'] =
          this.reviewSolutions.map((v) => v.toJson()).toList();
    }
    data['rank'] = this.rank;
    return data;
  }
}

class ReviewSolutions {
  int questionId;
  int userOption;

  ReviewSolutions({this.questionId, this.userOption});

  ReviewSolutions.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    userOption = json['userOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['userOption'] = this.userOption;
    return data;
  }
}
