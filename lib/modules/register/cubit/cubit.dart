// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm/modules/register/cubit/states.dart';
import 'package:smart_farm/modules/register/steps/contactInfo.dart';
import '../../../model/login_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../steps/accountInfo.dart';
import '../steps/personalInfo.dart';

class PlantRegisterCubit extends Cubit<PlantRegisterStates> {
  //account information
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKeyRegisterAccountInformation =
      GlobalKey<FormState>();

  //contact information
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  GlobalKey<FormState> formKeyRegisterContactInformation =
      GlobalKey<FormState>();
//Personal Information
  TextEditingController workFieldController = TextEditingController();
  TextEditingController usageTargetController = TextEditingController();

  GlobalKey<FormState> formKeyRegisterPersonalInformation =
      GlobalKey<FormState>();
  PlantRegisterCubit() : super(PlantRegisterInitialState());

  static PlantRegisterCubit get(context) => BlocProvider.of(context);

  PlantLoginModel? loginModel;

  void userRegister({required context}) async {
    emit(PlantRegisterLoadingState());
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Sign Up Wait......"),
            content: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
      print(
          "\n\n------------------------------RegisterDetails ------------------------------\n\n");
      print('"userName": ${userNameController.text},');
      print('"email": ${emailController.text},');
      print('"password": ${passwordController.text},');
      print('"confirmPassword": ${confirmPasswordController.text},');
      print('"phoneNumber": ${phoneNumberController.text},');
      print('"country": ${countryController.text},');
      print('"postCode": ${postCodeController.text},');
      print('"role": $cubitselectedOption,');
      print('"workField": ${workFieldController.text},');

      print(
          "\n\n------------------------------RegisterDetails ------------------------------\n\n");
      final response = await DioHelper.postData(url: registerEndPoint, query: {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "userName": userNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text,
        "phoneNumber": phoneNumberController.text,
        "streetName": streetNameController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "postCode": postCodeController.text,
        "role": cubitselectedOption,
        "workField": workFieldController.text,
        "usageTarget": usageTargetController.text,
      });
      print(response.data);
      loginModel = PlantLoginModel.fromJson(response.data);

      emit(PlantRegisterSuccessState(loginModel!));
      print(
          "\n\n------------------------------Success------------------------------\n\n");
    } catch (error) {
      print(error);

      emit(PlantRegisterErrorState(error.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibilityRegister() {
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(PlantRegisterChangePasswordVisibilityState());
  }

  /// ------------------------------------------------------------------
  List<Step> stepList() => [
        Step(
            state:
                activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: activeCurrentStep >= 0,
            title: Text(
              '1-First Step ',
              style: TextStyle(
                  fontFamily: "gillsans",
                  fontSize: 12.8,
                  fontWeight: FontWeight.bold,
                  backgroundColor: activeCurrentStep == 0
                      ? const Color(0xFF34D399)
                      : const Color(0xFFe5e7eb)),
            ),
            content: AccountInformationRegister(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              userNameController: userNameController,
              emailController: emailController,
              isPassword: isPassword,
              suffix: suffix,
              changePasswordVisibilityRegister:
                  changePasswordVisibilityRegister,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              formKeyUpdatePassword: formKeyRegisterAccountInformation,
            )),
        Step(
            state:
                activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: activeCurrentStep >= 1,
            title: Text(
              '2-Second Step ',
              style: TextStyle(
                  fontFamily: "gillsans",
                  fontSize: 12.8,
                  fontWeight: FontWeight.bold,
                  backgroundColor: activeCurrentStep == 1
                      ? const Color(0xFF34D399)
                      : const Color(0xFFe5e7eb)),
            ),
            content: ContactInformationRegister(
                phoneNumberController: phoneNumberController,
                streetNameController: streetNameController,
                cityController: cityController,
                stateController: stateController,
                countryController: countryController,
                postCodeController: postCodeController,
                formKeyContactInformation: formKeyRegisterContactInformation)),
        Step(
            state: StepState.complete,
            isActive: activeCurrentStep >= 2,
            title: Text(
              '3-Third Step',
              style: TextStyle(
                  fontSize: 12.8,
                  fontFamily: "gillsans",
                  fontWeight: FontWeight.bold,
                  backgroundColor: activeCurrentStep == 2
                      ? const Color(0xFF34D399)
                      : const Color(0xFFe5e7eb)),
            ),
            content: PersonalInformationRegister(
              selectedOption: cubitselectedOption,
              workFieldController: workFieldController,
              usageTargetController: usageTargetController,
              formKeyRegisterPersonalInformation:
                  formKeyRegisterPersonalInformation,
            ))
      ];
  int count = 0;
  int activeCurrentStep = 0;
  List<String> appBarName = [
    "Account Information \t \t  1/3",
    "Contact Information \t \t  2/3",
    "Personal Information\t \t  3/3"
  ];
  List appBarIcon = [
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
  ];
  void changeCurrentStep({required int index, int? val}) {
    if (index == 0) {
      count++;
      if (activeCurrentStep < (stepList().length - 1)) {
        activeCurrentStep += 1;
        appBarName[activeCurrentStep];
        emit(ChangeCurrentStepState());
      } else {
        emit(ChangeCurrentStepState());
      }
    }

    if (index == 1) {
      count = activeCurrentStep;
      if (activeCurrentStep == 0) {
        emit(ChangeCurrentStepState());
      } else {
        activeCurrentStep -= 1;
        count--;
        emit(ChangeCurrentStepState());
      }
    }
    if (index == 2) {
      activeCurrentStep = val!;
      count = activeCurrentStep;
      emit(ChangeCurrentStepState());
    }
  }

  bool checkVAlidation() {
    if (activeCurrentStep <= 0) {
      if (formKeyRegisterAccountInformation.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    } else if (activeCurrentStep == 1) {
      if (formKeyRegisterContactInformation.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    } else if (activeCurrentStep == 2) {
      if (formKeyRegisterPersonalInformation.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
