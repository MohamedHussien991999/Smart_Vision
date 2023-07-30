import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/plant_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/endpoints.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import 'details_states.dart';

class DetailsScreenCubit extends Cubit<DetailsScreenStates> {
  DetailsScreenCubit() : super(DetailsScreenInitialState());

  static DetailsScreenCubit get(context) => BlocProvider.of(context);
  int i = 0;
  Future<void> deleteImage(int id) async {
    emit(DetailsScreenLoadingState());
    FormData formData = FormData();
    formData.fields.add(MapEntry('x-auth-token', loginModelFinal!.token!));
    try {
      final response = await DioHelper.postData(
          url: "$api2/imagesModels/delete/$id",
          data: formData,
          headers: {
            'Content-Type': 'multipart/form-data',
          });
      print("------------------- Delete Image -------------------");
      print(response.data);
      print("------------------- Delete Image -------------------");
      plantModelFinal!.plantsHistory.clear();
      await getHistoryPlants();
    } catch (error) {
      if (error is DioError) {
        print('----------------');
        String? errorMessage = error.response!.data;
        print(errorMessage);
        emit(DeleteImageErrorState(
          errorMessage.toString(),
        ));
      } else {
        print('An error occurred while Get  the Feature : $error');
        emit(DeleteImageErrorState(
          error.toString(),
        ));
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

      emit(DeleteImageSuccessState());
    } catch (error) {
      print('----------------error at get History');
      if (error is DioError) {
        if (error.response?.data['message'] == null) {
          String errorMessage = error.response?.data;
          print(errorMessage);
          emit(DeleteImageErrorState(errorMessage));
        } else {
          String errorMessage = error.response?.data['message'];
          print(errorMessage);
          emit(DeleteImageErrorState(errorMessage));
        }
      } else {
        print('An error occurred while Get  the History : $error');
        emit(DeleteImageErrorState(
          error.toString(),
        ));
      }
    }
  }

  File Base64ImageConverter(String? image64, String? name) {
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
}
