import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_me/models/message_model.dart';

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

class LoginSuccessfulState extends RegisterationStates {
  UserCredential user;
  LoginSuccessfulState({required this.user});
}

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

//Get Messages from Firebase 

class GetMessagesLoadingState extends RegisterationStates 
{

}
class GetMessagesSuccessfulState extends RegisterationStates 
{
  List<MessageModel> messages;

  GetMessagesSuccessfulState({required this.messages});
}
class GetMessagesFromFireStoreState extends RegisterationStates 
{
  String errorMessage ;

  GetMessagesFromFireStoreState({required this.errorMessage});
}