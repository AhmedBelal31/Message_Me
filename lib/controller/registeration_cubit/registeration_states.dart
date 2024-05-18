import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_me/models/message_model.dart';

class RegistrationStates {}

class RegistrationInitialState extends RegistrationStates {}

//Register States
class RegistrationLoadingState extends RegistrationStates {}

class RegistrationSuccessfulState extends RegistrationStates {}

class RegistrationFailureState extends RegistrationStates {
  String errorMessage;
  RegistrationFailureState({required this.errorMessage});
}

// Login States
class LoginLoadingState extends RegistrationStates {}

class LoginSuccessfulState extends RegistrationStates {
  UserCredential user;
  LoginSuccessfulState({required this.user});
}

class LoginFailureState extends RegistrationStates {
  dynamic errorMessage;
  LoginFailureState({required this.errorMessage});
}

class SignoutLoadingState extends RegistrationStates {}

class SignoutSuccessfulState extends RegistrationStates {}

class SignoutFailureState extends RegistrationStates {
  dynamic errorMessage;
  SignoutFailureState({required this.errorMessage});
}

//Get Messages from Firebase 

class GetMessagesLoadingState extends RegistrationStates
{

}
class GetMessagesSuccessfulState extends RegistrationStates
{
  List<MessageModel> messages;

  GetMessagesSuccessfulState({required this.messages});
}
class GetMessagesFromFireStoreState extends RegistrationStates
{
  String errorMessage ;

  GetMessagesFromFireStoreState({required this.errorMessage});
}