class AssignedPerformace {
  int totalMatchesPlayed;
  int totalMatchesWinned;
  dynamic winningPercentage;
  dynamic averagePercentage;
  List<Strengths> strengths;
  List<Strengths> weeknesses;

  AssignedPerformace(
      {this.totalMatchesPlayed,
      this.totalMatchesWinned,
      this.winningPercentage,
      this.averagePercentage,
      this.strengths,
      this.weeknesses});

  AssignedPerformace.fromJson(Map<String, dynamic> json) {
    totalMatchesPlayed = json['totalMatchesPlayed'] ?? 0;
    totalMatchesWinned = json['totalMatchesWinned'] ?? 0;
    winningPercentage = json['winningPercentage'] ?? "0";
    averagePercentage = json['averagePercentage'] ?? 0.0;
    if (json['strengths'] != null) {
      strengths = new List<Strengths>();
      json['strengths'].forEach((v) {
        strengths.add(new Strengths.fromJson(v));
      });
    }
    if (json['weeknesses'] != null) {
      weeknesses = new List<Strengths>();
      json['weeknesses'].forEach((v) {
        weeknesses.add(Strengths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMatchesPlayed'] = this.totalMatchesPlayed;
    data['totalMatchesWinned'] = this.totalMatchesWinned;
    data['winningPercentage'] = this.winningPercentage;
    data['averagePercentage'] = this.averagePercentage;
    if (this.strengths != null) {
      data['strengths'] = this.strengths.map((v) => v.toJson()).toList();
    }
    if (this.weeknesses != null) {
      data['weeknesses'] = this.weeknesses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Strengths {
  String category;
  List<AllData> allData;
  int totalMatchesPlayed;
  int totalMatchesWinned;
  int percentage;

  Strengths(
      {this.category,
      this.allData,
      this.totalMatchesPlayed,
      this.totalMatchesWinned,
      this.percentage});

  Strengths.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['allData'] != null) {
      allData = new List<AllData>();
      json['allData'].forEach((v) {
        allData.add(new AllData.fromJson(v));
      });
    }
    totalMatchesPlayed = json['totalMatchesPlayed'];
    totalMatchesWinned = json['totalMatchesWinned'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.allData != null) {
      data['allData'] = this.allData.map((v) => v.toJson()).toList();
    }
    data['totalMatchesPlayed'] = this.totalMatchesPlayed;
    data['totalMatchesWinned'] = this.totalMatchesWinned;
    data['percentage'] = this.percentage;
    return data;
  }
}

class AllData {
  int quizId;
  int rank;
  String category;

  AllData({this.quizId, this.rank, this.category});

  AllData.fromJson(Map<String, dynamic> json) {
    quizId = json['quizId'];
    rank = json['rank'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quizId'] = this.quizId;
    data['rank'] = this.rank;
    data['category'] = this.category;
    return data;
  }
}
