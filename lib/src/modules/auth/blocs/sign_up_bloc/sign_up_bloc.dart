import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
	final UserRepository _userRepository;
	
  SignUpBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
	super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
			emit(SignUpProcess());
      try {
        MyUser user = await _userRepository.signUp(event.user, event.password);
				await _userRepository.setUserData(user);
				emit(SignUpSuccess());
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase auth errors here
        if (e.code == 'weak-password') {
          emit(SignUpFailure(message: 'The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          emit(SignUpFailure(message: 'The account already exists for that email.'));
        } else {
          emit(SignUpFailure(message: 'An unexpected error occurred. Please try again later.'));
        }
      } catch (e) {
        // Handle other errors
        emit(SignUpFailure(message: 'An error occurred during sign up. Please try again later.'));
      }
    });
  }
}