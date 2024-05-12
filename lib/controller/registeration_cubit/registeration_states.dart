class RegisterationStates {}

class RegisterationInitialState extends RegisterationStates {}

//Register States 
class RegisterationLoadingState extends RegisterationStates {}

class RegisterationSuccessfulState extends RegisterationStates {}

class RegisterationFailureState extends RegisterationStates {
  String errorMessage;
  RegisterationFailureState({required this.errorMessage});
}

// Login States 
class LoginLoadingState extends RegisterationStates {}

class LoginSuccessfulState extends RegisterationStates {}

class LoginFailureState extends RegisterationStates {
  dynamic errorMessage;
  LoginFailureState({required this.errorMessage});
}


class SignoutLoadingState extends RegisterationStates {}

class SignoutSuccessfulState extends RegisterationStates {}

class SignoutFailureState extends RegisterationStates {
  dynamic errorMessage;
  SignoutFailureState({required this.errorMessage});
}
