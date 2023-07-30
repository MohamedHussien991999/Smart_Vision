abstract class DetailsScreenStates {}

class DetailsScreenInitialState extends DetailsScreenStates {}

class DetailsScreenLoadingState extends DetailsScreenStates {}

class DeleteImageSuccessState extends DetailsScreenStates {}

class DeleteImageErrorState extends DetailsScreenStates {
  final String error;
  DeleteImageErrorState(this.error);
}
