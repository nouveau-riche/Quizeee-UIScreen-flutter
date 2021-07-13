class UserWalletModel {
  String sId;
  String walletId;
  int userId;
  List<Transactions> transactions;
  int winningbalance;
  int referralBalance;
  int refillBalance;
  List<AllBundles> allBundles;
  String document;
  String creationTimeStamp;

  UserWalletModel(
      {this.sId,
      this.walletId,
      this.userId,
      this.transactions,
      this.winningbalance,
      this.referralBalance,
      this.refillBalance,
      this.allBundles,
      this.document,
      this.creationTimeStamp});

  UserWalletModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    walletId = json['walletId'];
    userId = json['userId'];
    if (json['transactions'] != null) {
      transactions = new List<Transactions>();
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
    winningbalance = json['winningbalance'] ?? 0;
    referralBalance = json['referralBalance'] ?? 0;
    refillBalance = json['refillBalance'] ?? 0;
    if (json['allBundles'] != null) {
      allBundles = new List<AllBundles>();
      json['allBundles'].forEach((v) {
        allBundles.add(new AllBundles.fromJson(v));
      });
    }
    document = json['document'];
    creationTimeStamp = json['creationTimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['walletId'] = this.walletId;
    data['userId'] = this.userId;
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    data['winningbalance'] = this.winningbalance;
    data['referralBalance'] = this.referralBalance;
    data['refillBalance'] = this.refillBalance;
    if (this.allBundles != null) {
      data['allBundles'] = this.allBundles.map((v) => v.toJson()).toList();
    }
    data['document'] = this.document;
    data['creationTimeStamp'] = this.creationTimeStamp;
    return data;
  }
}

class Transactions {
  int amount;
  String transactionDateTimestamp;

  Transactions({this.amount, this.transactionDateTimestamp});

  Transactions.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    transactionDateTimestamp = json['transactionDateTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['transactionDateTimestamp'] = this.transactionDateTimestamp;
    return data;
  }
}

class AllBundles {
  String razorpayPaymentId;
  String razorpayOrderId;
  String razorpaySignature;
  String orgLogo;
  String orgName;
  String checkoutLogo;
  bool customBranding;

  AllBundles(
      {this.razorpayPaymentId,
      this.razorpayOrderId,
      this.razorpaySignature,
      this.orgLogo,
      this.orgName,
      this.checkoutLogo,
      this.customBranding});

  AllBundles.fromJson(Map<String, dynamic> json) {
    razorpayPaymentId = json['razorpay_payment_id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpaySignature = json['razorpay_signature'];
    orgLogo = json['org_logo'];
    orgName = json['org_name'];
    checkoutLogo = json['checkout_logo'];
    customBranding = json['custom_branding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['razorpay_order_id'] = this.razorpayOrderId;
    data['razorpay_signature'] = this.razorpaySignature;
    data['org_logo'] = this.orgLogo;
    data['org_name'] = this.orgName;
    data['checkout_logo'] = this.checkoutLogo;
    data['custom_branding'] = this.customBranding;
    return data;
  }
}
