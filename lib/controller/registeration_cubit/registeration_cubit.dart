import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'registeration_states.dart';

class RegisterationCubit extends Cubit<RegisterationStates> {
  RegisterationCubit() : super(RegisterationInitialState());

  void registerAccount({required email, required String password}) {
    emit(RegisterationLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterationSuccessfulState());
    }).catchError((errorMessage) {
      emit(RegisterationFailureState(errorMessage: errorMessage));
    });
  }
}
