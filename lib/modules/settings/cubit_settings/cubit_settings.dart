// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_farm/modules/settings/cubit_settings/states_settings.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../login/login_screen.dart';
import '../accountInformation/accountInformation.dart';
import '../contactInformation/contactInformation.dart';
import '../personalInformation/personalInformation.dart';
import '../updatePassword/updatePassword.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);
  File? image;
  //change password
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> formKeyUpdatePaswword = GlobalKey<FormState>();
  //account information
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKeyUpdateAccountInformation = GlobalKey<FormState>();

  //contact information
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  GlobalKey<FormState> formKeyUpdateContactInformation = GlobalKey<FormState>();
//Personal Information
  TextEditingController roleController = TextEditingController();
  TextEditingController workFieldController = TextEditingController();
  TextEditingController usageTargetController = TextEditingController();
  TextEditingController featuresController = TextEditingController();

  GlobalKey<FormState> formKeyUpdatePersonalInformation =
      GlobalKey<FormState>();
  String? hintFeatureString = loginModelFinal!.features?.join(', ');
//1-Change Photo
  void updateImage(BuildContext context) {
    emit(SettingsInitialUpdateLoadingState());
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 120,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.file,
                  color: kSecondary,
                ),
                title: const Text("Choose image"),
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  image = File(pickedFile!.path);
                  cubitimage = image;
                  sendImage(context);
                },
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.camera,
                  color: kSecondary,
                ),
                title: const Text("Take photo"),
                onTap: () async {
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  image = File(pickedFile!.path);
                  cubitimage = image;

                  sendImage(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void printFormDataContent(FormData formData) {
    formData.fields.forEach((field) {
      print('${field.key}: ${field.value}');
    });
  }

  Future<void> sendImage(context) async {
    emit(SettingsLoadingState("Updating Image ..."));
    String fileName = await image!.path.split('/').last;
    print(fileName);

    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image!.path,
        filename: fileName,
      ),
    });
    print("------------------- responsce model -------------------");
    printFormDataContent(data);
    print("------------------- responsce model -------------------");
    print("------------------- responsce model -------------------");
    try {
      final response = await DioHelper.putData(
          url: informationEndPoint,
          data: data,
          headers: {
            'x-auth-token': loginModelFinal!.token,
            'Content-Type': 'multipart/form-data',
          });

      print(response.data);

      loginModelFinal!.imageProfile = cubitimage;
      Navigator.of(context).pop();
      emit(SettingsSuccessState(" Image Updated Successfully ",
          popUpdateImageSuccess: "Updating Image ..."));
    } catch (error) {
      if (error is DioException) {
        print('----------------');
        String errorMessage = error.response?.data['message'];
        Navigator.of(context).pop();
        emit(SettingsErrorState(
          errorMessage.toString(),
        ));
      } else if (error
          .toString()
          .contains("Null check operator used on a null value")) {
        print('An error occurred while sending the image: $error');
        Navigator.of(context).pop();
        emit(SettingsErrorState(
          error.toString(),
        ));
      }
    }
  }

  ImageProvider changeImage() {
    if (cubitimage == null) {
      return const AssetImage('assets/images/Default_prf.png');
    } else {
      return FileImage(File(cubitimage!.path));
    }
  }

//2-singOut
  void signOut(context) async {
    emit(SettingsLoadingState(" Logging Out ..."));
    try {
      final responseLogout = await DioHelper.postData(
          url: logoutEndPoint, query: {}, token: loginModelFinal!.token);
      print(responseLogout.data);
      Navigator.of(context).pop();
      navigateAndFinish(context, const LoginScreen());

      emit(SettingsSuccessState(" Logout Successfully "));
    } catch (error) {
      if (error is DioException) {
        print('----------------');
        String? errorMessage = error.response?.data['message'];
        errorMessage ??= error.response?.data;
        emit(SettingsErrorState(errorMessage.toString()));
      } else {
        print('An error From Code occurred while Logout : $error');
        emit(SettingsErrorState(
          error.toString(),
        ));
      }
    }
  }

//3-Update Password
  void updatePasswordScreen(context) {
    oldPasswordController.text = "";
    newPasswordController.text = "";
    confirmNewPasswordController.text = "";
    emit(SettingsInitialUpdateLoadingState());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formKeyUpdatePaswword,
          child: AlertDialog(
            title: const Text(
              "   Change Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "gillsans",
              ),
            ),
            content: UpdatePasswordScreen(
                oldPasswordController: oldPasswordController,
                confirmNewPasswordController: confirmNewPasswordController,
                newPasswordController: newPasswordController),
            actions: [
              ConditionalBuilder(
                  condition: state is! SettingsUpdateLoadingState,
                  builder: (context) => TextButton(
                        onPressed: () {
                          // Perform any desired action here
                          if (formKeyUpdatePaswword.currentState!.validate()) {
                            emit(SettingsUpdateLoadingState());
                            updatePassword(context);
                            print("ok ");
                            print(loginModelFinal);
                          }
                          // Close the dialog
                        },
                        child: const Text(
                          'Update',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 25),
                        ),
                      ),
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
              TextButton(
                onPressed: () {
                  // Perform any desired action here
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updatePassword(context) async {
    try {
      final responseLogout = await DioHelper.putData(
          url: updatePasswordEndPoint,
          query: {
            'oldPassword': oldPasswordController.text,
            'password': newPasswordController.text,
            'confirmPassword': confirmNewPasswordController.text
          },
          token: loginModelFinal!.token);

      loginModelFinal!.password = newPasswordController.text;
      print(responseLogout.data);
      Navigator.of(context).pop();

      emit(SettingsSuccessState(" Password Updated Successfully "));
    } catch (error) {
      Navigator.of(context).pop();
      if (error is DioException) {
        print('----------------');
        String errorMessage = error.response?.data['message'];
        emit(SettingsErrorState(errorMessage.toString()));
      } else {
        print('An error From occurred while Update Password: $error');
        emit(SettingsErrorState(
          error.toString(),
        ));
      }
    }
  }

//4-Delete User
  void deleteUser(context) async {
    emit(SettingsLoadingState(" Deleting User ..."));
    try {
      final responseLogout = await DioHelper.deleteData(
          url: deleteEndPoint, query: {}, token: loginModelFinal!.token);
      print(responseLogout.data);
      Navigator.of(context).pop();
      navigateAndFinish(context, const LoginScreen());
      emit(SettingsSuccessState(" Delete User Successfully "));
    } catch (error) {
      if (error is DioException) {
        print('----------------');
        String errorMessage = error.response?.data['message'];
        emit(SettingsErrorState(errorMessage.toString()));
      } else {
        print('An error From occurred while Delete User : $error');
        emit(SettingsErrorState(
          error.toString(),
        ));
      }
    }
  }

//5-account information
  void updateAccountInformationScreen(context) {
    firstNameController.text = loginModelFinal!.firstName!;
    lastNameController.text = loginModelFinal!.lastName!;
    userNameController.text = loginModelFinal!.userName!;
    emailController.text = loginModelFinal!.email!;
    emit(SettingsInitialUpdateLoadingState());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formKeyUpdateAccountInformation,
          child: AlertDialog(
            title: const Text(
              "    Update AccountInformation....",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "gillsans",
              ),
            ),
            content: AccountInformation(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              userNameController: userNameController,
              emailController: emailController,
            ),
            actions: [
              ConditionalBuilder(
                  condition: state is! SettingsUpdateLoadingState,
                  builder: (context) => TextButton(
                        onPressed: () {
                          // Perform any desired action here
                          if (formKeyUpdateAccountInformation.currentState!
                              .validate()) {
                            emit(SettingsUpdateLoadingState());
                            updateAccountInformation(context);
                            print("ok ");
                          }
                          // Close the dialog
                        },
                        child: const Text(
                          'Update',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 25),
                        ),
                      ),
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
              TextButton(
                onPressed: () {
                  // Perform any desired action here
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void updateAccountInformation(context) async {
    emit(SettingsInitialUpdateLoadingState());
    try {
      await DioHelper.putData(
          url: informationEndPoint,
          query: {
            'firstName': firstNameController.text,
            'lastName': lastNameController.text,
            'userName': userNameController.text,
            'email': emailController.text,
          },
          token: loginModelFinal!.token);

      loginModelFinal!.firstName = firstNameController.text;
      loginModelFinal!.lastName = lastNameController.text;
      loginModelFinal!.userName = userNameController.text;
      loginModelFinal!.email = emailController.text;
      Navigator.of(context).pop();

      emit(SettingsSuccessState(" Account Information Updated Successfully "));
    } catch (error) {
      if (error is DioException) {
        print('----------------');
        String errorMessage = error.response?.data['message'];
        emit(SettingsErrorState(errorMessage.toString()));
      } else {
        print(
            'An error From Code occurred while Updated Account Information : $error');
        emit(SettingsErrorState(
          error.toString(),
        ));
      }
    }
  }

//6-contact information
  void updateContactInformationScreen(context) {
    phoneNumberController.text = loginModelFinal!.phoneNumber ?? "";
    cityController.text = loginModelFinal!.city ?? "";
    countryController.text = loginModelFinal!.country ?? "";
    postCodeController.text = loginModelFinal!.postCode ?? "";
    stateController.text = loginModelFinal!.state ?? "";
    streetNameController.text = loginModelFinal!.streetName ?? "";
    emit(SettingsInitialUpdateLoadingState());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formKeyUpdateContactInformation,
          child: AlertDialog(
            title: const Text(
              "    Update Contact Information....",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "gillsans",
              ),
            ),
            content: ContactInformation(
              phoneNumberController: phoneNumberController,
              cityController: cityController,
              countryController: countryController,
              postCodeController: postCodeController,
              stateController: stateController,
              streetNameController: streetNameController,
            ),
            actions: [
              ConditionalBuilder(
                  condition: state is! SettingsUpdateLoadingState,
                  builder: (context) => TextButton(
                        onPressed: () {
                          // Perform any desired action here
                          if (formKeyUpdateContactInformation.currentState!
                              .validate()) {
                            emit(SettingsUpdateLoadingState());
                            updateContactInformation(context);
                            print("ok ");
                          }
                          // Close the dialog
                        },
                        child: const Text(
                          'Update',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 25),
                        ),
                      ),
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
              TextButton(
                onPressed: () {
                  // Perform any desired action here
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void updateContactInformation(context) async {
    emit(SettingsInitialUpdateLoadingState());
    try {
      await DioHelper.putData(
          url: informationEndPoint,
          query: {
            'phoneNumber': phoneNumberController.text,
            'streetName': streetNameController.text,
            'city': cityController.text,
            'state': stateController.text,
            'country': countryController.text,
            'postCode': postCodeController.text,
          },
          token: loginModelFinal!.token);

      loginModelFinal!.phoneNumber = phoneNumberController.text;
      loginModelFinal!.streetName = streetNameController.text;
      loginModelFinal!.city = cityController.text;
      loginModelFinal!.country = countryController.text;
      loginModelFinal!.postCode = postCodeController.text;
      loginModelFinal!.state = stateController.text;
      Navigator.of(context).pop();

      emit(SettingsSuccessState(" Contact Information Updated Successfully "));
    } catch (error) {
      Navigator.of(context).pop();

      if (error is DioException) {
        print('----------------');
        String errorMessage = error.response?.data['message'];
        emit(SettingsErrorState(errorMessage.toString()));
      } else {
        print(
            'An error From Code occurred while Updated Contact Information : $error');
        emit(SettingsErrorState(
          error.toString(),
        ));
      }
    }
  }

//7-Personal information
  void updatePersonalInformationScreen(context) {
    roleController.text = loginModelFinal!.role ?? "";
    featuresController.text = hintFeatureString ?? "";
    usageTargetController.text = loginModelFinal!.usageTarget ?? "";
    workFieldController.text = loginModelFinal!.workField ?? "";
    emit(SettingsInitialUpdateLoadingState());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formKeyUpdatePersonalInformation,
          child: AlertDialog(
            title: const Text(
              "    Update Personal Information....",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "gillsans",
              ),
            ),
            content: PersonalInformation(
              featuresController: featuresController,
              roleController: roleController,
              usageTargetController: usageTargetController,
              workFieldController: workFieldController,
            ),
            actions: [
              ConditionalBuilder(
                  condition: state is! SettingsUpdateLoadingState,
                  builder: (context) => TextButton(
                        onPressed: () {
                          // Perform any desired action here
                          if (formKeyUpdatePersonalInformation.currentState!
                              .validate()) {
                            emit(SettingsUpdateLoadingState());
                            updatePersonalInformation(context);
                            print("ok ");
                          }
                          // Close the dialog
                        },
                        child: const Text(
                          'Update',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 25),
                        ),
                      ),
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
              TextButton(
                onPressed: () {
                  // Perform any desired action here
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void updatePersonalInformation(context) async {
    emit(SettingsInitialUpdateLoadingState());
    try {
      await DioHelper.putData(
          url: informationEndPoint,
          query: {
            'role': roleController.text,
            'workField': workFieldController.text,
            'usageTarget': usageTargetController.text,
            'features': loginModelFinal!.features!,
          },
          token: loginModelFinal!.token);

      Navigator.of(context).pop();

      emit(SettingsSuccessState(" Personal Information Updated Successfully "));
    } catch (error) {
      Navigator.of(context).pop();

      if (error is DioException) {
        print('----------------');
        String errorMessage = error.response?.data['message'];
        emit(SettingsErrorState(errorMessage.toString()));
      } else {
        print(
            'An error From Code occurred while Updated Personal Information : $error');
        emit(SettingsErrorState(
          error.toString(),
        ));
      }
    }
  }
}
