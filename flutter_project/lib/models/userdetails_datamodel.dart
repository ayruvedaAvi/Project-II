class UserDetailsDataModel {
  String? profileImg;
  String? userName;
  String? workDescription;
  String? image;

  UserDetailsDataModel(
      {this.profileImg, this.userName, this.workDescription, this.image});

  UserDetailsDataModel.fromJson(Map<String, dynamic> json) {
    profileImg = json['profileImg'];
    userName = json['userName'];
    workDescription = json['Work_Description'];
    image = json['image'];
  }
}
