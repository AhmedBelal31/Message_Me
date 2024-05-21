import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me/controller/registeration_cubit/registeration_states.dart';
import 'package:message_me/models/message_model.dart';
import '../../const.dart';


class RegistrationCubit extends Cubit<RegistrationStates> {
  RegistrationCubit() : super(RegistrationInitialState());

  String userEmail = '';
  void registerAccount({required String email, required String password}) {
    emit(RegistrationLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegistrationSuccessfulState());
    }).catchError((error) {
      String errorMessage = handleFirebaseRegisterErrors(error);
      emit(RegistrationFailureState(errorMessage: errorMessage));
    });
  }

  String handleFirebaseRegisterErrors(error) {
    String errorMessage = 'An error occurred';
    if (error is FirebaseAuthException) {
      // Handle specific Firebase Auth errors
      switch (error.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        // Handle other Firebase Auth errors here
        default:
          errorMessage = 'Authentication failed. Please try again later.';
          break;
      }
    } else {
      // Handle other errors that are not related to Firebase Auth
      errorMessage = 'An unexpected error occurred. Please try again later.';
    }
    return errorMessage;
  }

  void loginToAccount({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {

      emit(LoginSuccessfulState(user: user));
    }).catchError(
      (error) {
        String errorMessage = 'An error occurred. Please try again later.';
        errorMessage = handleFirebaseLoginErrors(error, errorMessage);
        emit(LoginFailureState(errorMessage: errorMessage));
      },
    );
  }

  String handleFirebaseLoginErrors(error, String errorMessage) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage =
              'Invalid email address format. Please enter a valid email.';
          break;

        case 'user-disabled':
          errorMessage =
              'This user account has been disabled. Please contact support.';
          break;
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          errorMessage = 'Invalid email or password. Please try again.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many login attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          errorMessage =
              'Email/password accounts are not enabled. Please contact support.';
          break;
        // Handle other specific error cases here
      }
    } else {
      // Handle other errors that are not related to Firebase Auth
      errorMessage = 'An unexpected error occurred. Please try again later.';
    }
    return errorMessage;
  }

// Create SignOut Method

  void signOut() async {
    emit(SignoutLoadingState());
    FirebaseAuth.instance.signOut().then((_) {
      emit(SignoutSuccessfulState());
    }).catchError((error) {
      String errorMessage = "Error signing out";
      if (error is FirebaseAuthException) {
        errorMessage = error.message ?? "Unknown error";
      }
      emit(SignoutFailureState(errorMessage: errorMessage));
    });
  }

  void addMessageToFireStore({required message, required String email , required String dateTime}) {
    MessageModel messageModel = MessageModel(
        message: message, email: email, messageTime: dateTime);

    FirebaseFirestore.instance
        .collection(kMessageCollection)
        .add(messageModel.toJson());
  }

  List<MessageModel> messages = [];

  void getMessagesFromFireStore() {
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection(kMessageCollection)
        .orderBy('messageTime' , descending: true)
        .snapshots()
        .listen(
      (messagesCollection) {
        messages = [];
        for (var e in messagesCollection.docs) {
          messages.add(MessageModel.fromJson(e.data()));
          print('message is ${e.data()}');
        }

        // messages = messagesCollection.docs
        //     .map((e) => MessageModel.fromJson(e.data()))
        //     .toList();

        print('messages is $messages');
        emit(GetMessagesSuccessfulState(messages: messages));
      },
    );
  }
}
