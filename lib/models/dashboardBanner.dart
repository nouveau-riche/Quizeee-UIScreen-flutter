class DashboardBanner {
  String sId;
  int bannerId;
  String bannerName;
  String bannerImg;
  String bannerURL;
  int bannerStatus;
  DashboardBanner(
      {this.sId,
      this.bannerId,
      this.bannerName,
      this.bannerImg,
      this.bannerStatus,
      this.bannerURL});

  DashboardBanner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bannerId = json['bannerId'];
    bannerName = json['bannerName'];
    bannerImg = json['bannerImg'];
    bannerStatus = json['bannerStatus'] ?? 0;
    bannerURL = json['bannerURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bannerId'] = this.bannerId;
    data['bannerName'] = this.bannerName;
    data['bannerImg'] = this.bannerImg;
    return data;
  }
}
