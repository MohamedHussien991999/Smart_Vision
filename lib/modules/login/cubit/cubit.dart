// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm/model/plant_model.dart';
import 'package:smart_farm/modules/login/cubit/states.dart';
import '../../../model/login_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';

class PlantLoginCubit extends Cubit<PlantLoginStates> {
  PlantLoginCubit() : super(PlantLoginInitialStates());
  PlantLoginModel? loginModel;
  static PlantLoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(PlantLoginLoadingStates());

    try {
      await DioHelper.postData(url: loginEndPoint, query: {
        'email': email,
        'password': password,
      }).then(
        (value) {
          print(value.data);
          loginModelFinal = PlantLoginModel.fromJson(value.data);

          loginModelFinal!.email = email;
          loginModelFinal!.password = password;
        },
      );
      await getInf();
      await getFeatures();
      await getHistoryPlants();
    } catch (error) {
      if (error is DioException) {
        String? errorMessage;
        print('----------------');
        if (error.response?.statusCode == 503) {
          errorMessage = error.response?.data;

          // Handle the 503 status code here
        } else {
          errorMessage = error.response?.data['message'];
        }

        emit(PlantLoginErrorStates(errorMessage.toString()));
      } else {
        print('An error occurred while sending the image: $error');
        emit(PlantLoginErrorStates(error.toString()));
      }
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(PlantChangePasswordVisibilityStates());
  }

  Future<void> getInf() async {
    loginModel = loginModelFinal;
    loginModel!.token = loginModelFinal!.token;
    loginModel!.message = loginModelFinal!.message;
    loginModel!.userId = loginModelFinal!.userId;
    loginModel!.role = loginModelFinal!.role;

    try {
      final responseGetInfo = await DioHelper.getData(
        url: informationEndPoint,
        token: loginModelFinal!.token,
      );
      loginModelFinal = PlantLoginModel.fromJson2(responseGetInfo.data);
      loginModelFinal!.token = loginModel!.token;
      loginModelFinal!.imageProfile = await Base64ImageConverter(
          loginModelFinal!.image64, 'imageProfile${loginModelFinal!.userId}');
      print("--------------------------");
      print("get Info Success");
      print("--------------------------");
    } catch (error) {
      if (error is DioException) {
        print('----------------error at get Info');
        String errorMessage = error.response?.data['message'];
        emit(PlantLoginErrorStates(errorMessage.toString()));
        return;
      } else {
        print('An error occurred while Get  the User Information: $error');
        emit(PlantLoginErrorStates(error.toString()));
        return;
      }
    }
  }

  Future<void> getFeatures() async {
    try {
      await DioHelper.getData(
        url: getMyFeaturesEndPoint,
        token: loginModelFinal!.token,
      ).then((value) {
        loginModelFinal?.featuresDetails =
            value.data['data'].cast<Map<String, dynamic>>().toList();
      });

      print("--------------------------");
      print("get Features Success");
      print("--------------------------");
    } catch (error) {
      if (error is DioException) {
        print('----------------');
        String errorMessage = error.response?.data['message'];
        emit(PlantLoginErrorStates(errorMessage.toString()));
      } else {
        print('An error occurred while Get  the Feature : $error');
        emit(PlantLoginErrorStates(error.toString()));
      }
    }
  }

  Future<void> getHistoryPlants() async {
    FormData formData = FormData();
    formData.fields.add(MapEntry('x-auth-token', loginModelFinal!.token!));
    try {
      await DioHelper.postData(
        url: getHistoryEndPoint,
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ).then((value) async {
        print(value.data['data']);
        int i = 0;
        for (var item in value.data['data']) {
          var plantData = Plant.fromJson(item);
          plantData.image = await Base64ImageConverter(
              plantData.imageFile64, 'originalImagenum$i');
          plantData.imagePath = plantData.image!.path;
          if (plantData.resultImage64 != null) {
            plantData.resultImage = await Base64ImageConverter(
                plantData.resultImage64, 'resultImageNumb$i');
            plantData.resultImagePath = plantData.resultImage?.path;
            i++;
          }
          plantModelFinal ??= plantData;
          plantModelFinal!.plantsHistory.add(plantData);
        }
      });

      print("--------------------------");
      print("get History Success");
      print("--------------------------");
      print(plantModelFinal?.plantsHistory);

      emit(
          PlantLoginSuccessStates(loginModelFinal!.message ?? 'Login Success'));
    } catch (error) {
      print('----------------error at get History');
      if (error is DioException) {
        if (error.response?.data['message'] == null) {
          String errorMessage = error.response?.data;
          print(errorMessage);
          emit(PlantLoginErrorStates(errorMessage.toString()));
        } else {
          String errorMessage = error.response?.data['message'];
          print(errorMessage);
          emit(PlantLoginErrorStates(errorMessage.toString()));
        }
      } else {
        print('An error occurred while Get  the History : $error');
        emit(PlantLoginErrorStates(error.toString()));
      }
    }
  }

  File Base64ImageConverter(String? image64, String? name) {
    if (image64 == null) {
      return File('assets/images/Default_prf.png');
    } else {
      Uint8List bytes = base64Decode(image64);

      // Create a temporary file
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/$name.png');

      // Write the bytes to the file
      tempFile.writeAsBytesSync(bytes);
      return tempFile;
    }
  }
}
