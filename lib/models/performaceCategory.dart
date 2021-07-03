class PerformanceCategory {
  List<PublicGraph> publicGraph;
  List<PublicGraph> assignedGraph;

  PerformanceCategory({this.publicGraph, this.assignedGraph});

  PerformanceCategory.fromJson(Map<String, dynamic> json) {
    if (json['publicGraph'] != null) {
      publicGraph = new List<PublicGraph>();
      json['publicGraph'].forEach((v) {
        publicGraph.add(new PublicGraph.fromJson(v));
      });
    }
    if (json['assignedGraph'] != null) {
      assignedGraph = new List<PublicGraph>();
      json['assignedGraph'].forEach((v) {
        assignedGraph.add(new PublicGraph.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.publicGraph != null) {
      data['publicGraph'] = this.publicGraph.map((v) => v.toJson()).toList();
    }
    if (this.assignedGraph != null) {
      data['assignedGraph'] =
          this.assignedGraph.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PublicGraph {
  String category;
  List<AllData> allData;
  int winningPercentage;

  PublicGraph({this.category, this.allData, this.winningPercentage});

  PublicGraph.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['allData'] != null) {
      allData = new List<AllData>();
      json['allData'].forEach((v) {
        allData.add(new AllData.fromJson(v));
      });
    }
    winningPercentage = json['winningPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.allData != null) {
      data['allData'] = this.allData.map((v) => v.toJson()).toList();
    }
    data['winningPercentage'] = this.winningPercentage;
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
