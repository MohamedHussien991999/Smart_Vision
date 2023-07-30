abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

class SettingsLoadingState extends SettingsStates {
  final String stateNow;

  SettingsLoadingState(this.stateNow);
}

class SettingsChangePhotoState extends SettingsStates {}

class SettingsSuccessState extends SettingsStates {
  final String message;
  String? popUpdateImageSuccess;
  SettingsSuccessState(this.message, {this.popUpdateImageSuccess});
}

class SettingsErrorState extends SettingsStates {
  String? popUpdateImage;
  final String error;
  SettingsErrorState(this.error, {this.popUpdateImage});
}

class SettingsUpdateLoadingState extends SettingsStates {}

class SettingsInitialUpdateLoadingState extends SettingsStates {}
