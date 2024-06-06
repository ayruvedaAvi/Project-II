class UserDetailsDataModel {
  String? profileImg;
  String? userName;
  String? workDescription;
  String? image;
  String? title;
  double? price;

  UserDetailsDataModel({
    this.profileImg,
    this.userName,
    this.workDescription,
    this.image,
    this.title,
    this.price,
  });

  UserDetailsDataModel.fromJson(Map<String, dynamic> json) {
    profileImg = json['profileImg'];
    userName = json['userName'];
    workDescription = json['Work_Description'];
    image = json['image'];
    title = json['Title'];
    price = json['price'];
  }
}
