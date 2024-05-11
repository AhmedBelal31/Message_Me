class RegisterationStates {}

class RegisterationInitialState extends RegisterationStates {}

class RegisterationLoadingState extends RegisterationStates {}

class RegisterationSuccessfulState extends RegisterationStates {}

class RegisterationFailureState extends RegisterationStates {
  String errorMessage;
  RegisterationFailureState({required this.errorMessage});
}
