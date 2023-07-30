import 'package:smart_farm/model/video_model.dart';

import '../../../model/plant_model.dart';

abstract class DetectionStates {}

class DetectionInitialState extends DetectionStates {}

class DetectionLoadingState extends DetectionStates {
  final String stateNow;

  DetectionLoadingState(this.stateNow);
}

class DetectionHandleModelSelectionState extends DetectionStates {}

class DetectionSuccessState extends DetectionStates {
  final String message;
  Plant modelPlantDetails;
  DetectionSuccessState(this.message, this.modelPlantDetails);
}

class DetectionErrorState extends DetectionStates {
  final String error;
  DetectionErrorState(this.error);
}

class GetHistorySuccessState extends DetectionStates {}

class GetHistoryErrorState extends DetectionStates {}

class DetectionVideoSuccessState extends DetectionStates {
  final String message;
  VideoModel modelViedoDetails;
  DetectionVideoSuccessState(this.message, this.modelViedoDetails);
}

class DetectionVideoErrorState extends DetectionStates {
  final String error;
  DetectionVideoErrorState(this.error);
}

class GetVideoSuccessState extends DetectionStates {}

class GetVideoErrorState extends DetectionStates {}
