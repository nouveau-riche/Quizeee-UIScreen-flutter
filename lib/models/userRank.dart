class UserRank {
  int resultId;
  int userId;
  int score;
  int responseTime;
  int rank;
  String prize;

  UserRank(
      {this.resultId,
      this.userId,
      this.score,
      this.responseTime,
      this.rank,
      this.prize});

  UserRank.fromJson(Map<String, dynamic> json) {
    resultId = json['resultId'];
    userId = json['userId'];
    score = json['score'];
    responseTime = json['responseTime'];
    rank = json['rank'];
    prize = json['prize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultId'] = this.resultId;
    data['userId'] = this.userId;
    data['score'] = this.score;
    data['responseTime'] = this.responseTime;
    data['rank'] = this.rank;
    data['prize'] = this.prize;
    return data;
  }
}
