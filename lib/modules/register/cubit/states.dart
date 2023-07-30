import '../../../model/login_model.dart';

abstract class PlantRegisterStates {}

class PlantRegisterInitialState extends PlantRegisterStates {}

class PlantRegisterLoadingState extends PlantRegisterStates {}

class PlantRegisterSuccessState extends PlantRegisterStates {
  final PlantLoginModel loginModel;

  PlantRegisterSuccessState(this.loginModel);
}

class PlantRegisterErrorState extends PlantRegisterStates {
  final String error;

  PlantRegisterErrorState(this.error);
}

class PlantRegisterChangePasswordVisibilityState extends PlantRegisterStates {}

class ChangeRoleRegisterState extends PlantRegisterStates {}

class ChangeFeature1RegisterState extends PlantRegisterStates {}

class ChangeFeature2RegisterState extends PlantRegisterStates {}

class ChangeFeature3RegisterState extends PlantRegisterStates {}

class TestFeature3Register extends PlantRegisterStates {}

class ChangeCurrentStepState extends PlantRegisterStates {}
