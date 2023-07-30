abstract class PlantLoginStates {}

class PlantLoginInitialStates extends PlantLoginStates {}

class PlantLoginLoadingStates extends PlantLoginStates {}

class PlantLoginSuccessStates extends PlantLoginStates {
  final String loginMessaga;

  PlantLoginSuccessStates(this.loginMessaga);
}

class PlantLoginErrorStates extends PlantLoginStates {
  final String error;

  PlantLoginErrorStates(this.error);
}

class PlantChangePasswordVisibilityStates extends PlantLoginStates {}
