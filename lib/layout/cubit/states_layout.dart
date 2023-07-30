abstract class PlantLayoutStates {}

class PlantLayoutInitialState extends PlantLayoutStates {}

class PlantLayoutBottomNavBarState extends PlantLayoutStates {}

class PlantLayoutHomeSuccessStates extends PlantLayoutStates {
  PlantLayoutHomeSuccessStates();
}

class PlantLayoutHomeErrorStates extends PlantLayoutStates {
  final String error;

  PlantLayoutHomeErrorStates(this.error);
}
