import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_farm/model/login_model.dart';
import 'package:smart_farm/model/plant_model.dart';
import 'package:smart_farm/model/video_model.dart';

const kMain = Color(0xff00ad59);
const kSecondary = Color(0xff626463);
const kWhite = Color(0xffffffff);
String loginSuccess = "Login successfully..!";
String registerSuccess = "User Created Successfully :)";
PlantLoginModel? loginModelFinal;
Plant? plantModelFinal;
VideoModel? VideoModelFnal;
String? cubitselectedOption;
File? cubitimage;
File? imageDetection;
File? videoDetection;
