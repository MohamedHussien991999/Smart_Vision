import 'dart:io';

class PlantLoginModel {
  String? message;
  String? token;
  int? userId;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? role;
  String? phoneNumber;
  String? workField;
  String? usageTarget;
  String? streetName;
  String? city;
  String? state;
  String? country;
  String? postCode;
  List<Map<String, dynamic>>? featuresDetails;
  List? features;
  String? image64;
  File? imageProfile;
  String? imageName;

  PlantLoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    userId = json['user_id'];
    role = json['role'];
  }
  PlantLoginModel.fromJson2(Map<String, dynamic> data) {
    userId = data['data']['user']['id'];
    firstName = data['data']['user']['firstName'];
    lastName = data['data']['user']['lastName'];
    userName = data['data']['user']['userName'];
    email = data['data']['user']['email'];
    role = data['data']['user']['role'];
    phoneNumber = data['data']['user']['phoneNumber'];
    workField = data['data']['user']['workField'];
    usageTarget = data['data']['user']['usageTarget'];
    streetName = data['data']['user']['streetName'];
    city = data['data']['user']['city'];
    country = data['data']['user']['country'];
    postCode = data['data']['user']['postCode'];
    features = data['data']['features'];
    image64 = data['data']['user']['image'];

    // Write the bytes to the file
  }
}
