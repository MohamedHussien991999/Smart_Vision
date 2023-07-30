import 'package:smart_farm/shared/components/constants.dart';

String api1 = "https://farm-vision.onrender.com/api";
String api2 = "https://test-ml-api.onrender.com/api";

String loginEndPoint = '$api1/login';
String registerEndPoint = "$api1/user";
String logoutEndPoint = '$api1/logout';
String updatePasswordEndPoint = '$api1/password/${loginModelFinal!.userId}';
String deleteEndPoint = '$api1/user/${loginModelFinal!.userId}';
String informationEndPoint = '$api1/user/${loginModelFinal!.userId}';
String getImageEndPoint = "$api1/logo/${loginModelFinal!.imageName}";
String getMyFeaturesEndPoint = "$api1/feature/getUserFeatures";
String getResultImageDetectionEndPoint = "$api2/imagesModels/process";
String getResultVideoDetectionEndPoint = "$api2/videosModels/process";
String getVideo = "$api2/getVideo";
String getHistoryEndPoint = "$api2/imagesModels/get";
