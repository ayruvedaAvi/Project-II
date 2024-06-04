class UserDetailsDataModel {
  String? profileImg;
  String? userName;
  String? descText;
  String? postImg;

  UserDetailsDataModel(
      {this.profileImg, this.userName, this.descText, this.postImg});

  UserDetailsDataModel.fromJson(Map<String, dynamic> json) {
    profileImg = json['profileImg'];
    userName = json['userName'];
    descText = json['descText'];
    postImg = json['postImg'];
  }
}
