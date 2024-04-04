import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
class SignInBloc extends Bloc<SignInEvent, SignInState> {
	final UserRepository _userRepository;
	
  SignInBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
	super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
			emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
				emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase auth errors here
         if (e.code == 'user-not-found') {
          emit(SignInFailure(emailMessage: 'No user for this email'));
        } else if (e.code == 'wrong-password') {
          emit(SignInFailure(passwordMessage: 'Wrong Password'));
        }
      } catch (e) {
        // Handle other errors
        emit(SignInFailure(emailMessage: 'An error occurred during sign in. Please try again later.'));
      }
    });
		on<ResetPassword>((event, emit) async {
			try {
				await _userRepository.resetPassword(event.email);
				emit(ResetPasswordSuccess());
			} catch (e) {
				emit(ResetPasswordFailure());
			}
    });
		on<SignOutRequired>((event, emit) async {
			await _userRepository.logOut();
    });
  }
}