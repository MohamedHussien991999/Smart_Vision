// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import '../../../model/plant_model.dart';
import '../../../model/video_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'detection_states.dart';

class DetectionCubit extends Cubit<DetectionStates> {
  DetectionCubit() : super(DetectionInitialState());
  List<String> selectedModels = [];
  Plant responseModelPlant = Plant();
  VideoModel responseModelVideoPlant = VideoModel();
  int i = 0;
  List imageAvailableModels = loginModelFinal!.featuresDetails!
      .where((map) => map["type"] == "image")
      .map((map) => map["feature"] as String)
      .toList();
  List imageFeatureDescriptions = loginModelFinal!.featuresDetails!
      .where((map) => map["type"] == "image")
      .map((map) => map["describtion"] as String)
      .toList();
  List videoAvailableModels = loginModelFinal!.featuresDetails!
      .where((map) => map["type"] == "video")
      .map((map) => map["feature"] as String)
      .toList();
  List videoFeatureDescriptions = loginModelFinal!.featuresDetails!
      .where((map) => map["type"] == "video")
      .map((map) => map["describtion"] as String)
      .toList();

  static DetectionCubit get(context) => BlocProvider.of(context);

  void handleModelSelection(bool selected, String model) {
    if (selected) {
      selectedModels.add(model);
    } else {
      selectedModels.remove(model);
    }
    print(selectedModels);
    emit(DetectionHandleModelSelectionState());
  }

  Future<void> processModelImage() async {
    emit(DetectionLoadingState('Processing Image Waiting ....'));
    String fileName = await imageDetection!.path.split('/').last;
    FormData formData = FormData();
    formData.fields.add(MapEntry('x-auth-token', loginModelFinal!.token!));

    for (int i = 0; i < selectedModels.length; i++) {
      formData.fields.add(MapEntry('features[]', selectedModels[i]));
    }

    MultipartFile multipartFile = await MultipartFile.fromFile(
        imageDetection!.path,
        filename: fileName,
        contentType: MediaType('type', 'multipart/form-data'));
    formData.files.add(MapEntry('image', multipartFile));
    print(formData.fields);
    print(formData.files);

    try {
      final response = await DioHelper.postData(
          url: getResultImageDetectionEndPoint,
          data: formData,
          headers: {
            'Content-Type': 'multipart/form-data',
            'Content-Length': multipartFile.length,
          });
      responseModelPlant = Plant.fromJson(response.data);
      responseModelPlant.image = base64ImageDetectionConverter(
          responseModelPlant.imageFile64, 'originalImage num$i');
      responseModelPlant.imagePath = responseModelPlant.image!.path;
      if (responseModelPlant.resultImage64 != null) {
        responseModelPlant.resultImage = base64ImageDetectionConverter(
            responseModelPlant.resultImage64, 'resultImageNumb$i');
        responseModelPlant.resultImagePath =
            responseModelPlant.resultImage?.path;
        i++;
      }
      plantModelFinal ??= responseModelPlant;
      plantModelFinal!.plantsHistory.clear();
      await getHistoryPlants();
      print("------------------- response model -------------------");
      print(response.data);
      print("------------------- response model -------------------");

      emit(DetectionSuccessState(response.data['message'], responseModelPlant));
    } catch (error) {
      if (error is DioException) {
        print('----------------');
        if (error.response?.data['message'] == null) {
          String? errorMessage = error.response!.data;
          print(errorMessage);
          emit(DetectionErrorState(errorMessage.toString()));
        } else {
          String? errorMessage = error.response!.data['message'];
          print(errorMessage);
          emit(DetectionErrorState(errorMessage.toString()));
        }
      } else {
        print('An error occurred while Get  the Feature : $error');
        emit(DetectionErrorState(error.toString()));
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
          plantData.image = base64ImageDetectionConverter(
              plantData.imageFile64, 'originalImageNum$i');
          plantData.imagePath = plantData.image!.path;
          if (plantData.resultImage64 != null) {
            plantData.resultImage = base64ImageDetectionConverter(
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

      emit(GetHistorySuccessState());
    } catch (error) {
      print('----------------error at get History');
      if (error is DioException) {
        if (error.response?.data['message'] == null) {
          String errorMessage = error.response?.data;
          print(errorMessage);
          emit(GetHistoryErrorState());
        } else {
          String errorMessage = error.response?.data['message'];
          print(errorMessage);
          emit(GetHistoryErrorState());
        }
      } else {
        print('An error occurred while Get  the History : $error');
        emit(GetHistoryErrorState());
      }
    }
  }

  File base64ImageDetectionConverter(String? image64, String? name) {
    if (image64 == null) {
      return File('assets/images/Default_prf.png');
    } else {
      Uint8List bytes = base64Decode(image64);

      // Create a temporary file
      final tempDirResponse = Directory.systemTemp;
      final tempFile = File('${tempDirResponse.path}/$name$i.png');

      // Write the bytes to the file
      tempFile.writeAsBytesSync(bytes);
      i++;
      return tempFile;
    }
  }

  Future<void> processModelVideo() async {
    emit(DetectionLoadingState('Processing Video Waiting ....'));
    String fileName = await videoDetection!.path.split('/').last;
    FormData formData = FormData();
    formData.fields.add(MapEntry('x-auth-token', loginModelFinal!.token!));

    for (int i = 0; i < selectedModels.length; i++) {
      formData.fields.add(MapEntry('features[]', selectedModels[i]));
    }

    MultipartFile multipartFile = await MultipartFile.fromFile(
        videoDetection!.path,
        filename: fileName,
        contentType: MediaType('type', 'multipart/form-data'));
    formData.files.add(MapEntry('video', multipartFile));
    print(formData.fields);
    print(formData.files);

    try {
      final response = await DioHelper.postData(
          url: getResultVideoDetectionEndPoint,
          data: formData,
          headers: {
            'Content-Type': 'multipart/form-data',
            'Content-Length': await multipartFile.length,
          });
      responseModelVideoPlant = VideoModel.fromJson(response.data);
      responseModelVideoPlant.video = videoDetection;
      VideoModelFnal ??= responseModelVideoPlant;
      print("------------------- response model -------------------");
      print(response.data);
      print("------------------- response model -------------------");

      emit(DetectionVideoSuccessState(
          response.data['message'], responseModelVideoPlant));
    } catch (error) {
      if (error is DioException) {
        print('----------------');
        if (error.response!.data['message'] == null) {
          String? errorMessage = error.response!.data;
          print(errorMessage);
          emit(DetectionErrorState(errorMessage.toString()));
        } else {
          String? errorMessage = error.response!.data['message'];
          print(errorMessage);
          emit(DetectionErrorState(errorMessage.toString()));
        }
      } else {
        print('An error occurred while Get  the Feature : $error');
        emit(DetectionErrorState(error.toString()));
      }
    }
  }

  Future<File?> getVideoProcess(String? endpoint, String name) async {
    FormData formData = FormData();
    formData.fields.add(MapEntry('x-auth-token', loginModelFinal!.token!));
    try {
      final responseVideo = await DioHelper.postData(
        url: '$getVideo/$endpoint',
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );
      print(responseVideo.data);
      // Create a temporary file
      final tempDirResponse = Directory.systemTemp;
      final tempFile = File('${tempDirResponse.path}/$name.mp4');

      // Write the bytes to the file
      tempFile.writeAsBytesSync(responseVideo.data);
      Uint8List videoBlob = Uint8List.fromList(responseVideo.data);
      print(videoBlob);

      print("--------------------------");
      print("get Video  Success");
      print("--------------------------");
      emit(GetVideoSuccessState());
      return tempFile;
    } catch (error) {
      print('----------------error at get Video');
      if (error is DioException) {
        if (error.response?.data['message'] == null) {
          String errorMessage = error.response?.data;
          print(errorMessage);
          emit(DetectionErrorState(errorMessage.toString()));
        } else {
          String errorMessage = error.response?.data['message'];
          print(errorMessage);
          emit(DetectionErrorState(errorMessage.toString()));
        }
      } else {
        print('An error occurred while Get  the History : $error');
        emit(DetectionErrorState(error.toString()));
      }
      return null;
    }
  }
}
