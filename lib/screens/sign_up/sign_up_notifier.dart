import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/network/auth_exception.dart';
import 'package:note_app/network/provider/auth_provider.dart';
import 'package:note_app/screens/sign_up/sign_up_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpNotifier(this.ref) : super(const SignUpStateInitial());

  void signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const SignUpStateLoading();
    try {
      await ref.read(authRepositoryProvider).signUpWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          );

      state = const SignUpStateSuccess();
    } catch (e) {
      if (e is AuthException) {
        state = SignUpStateFailure(e.message.toString());
      } else {
        state = SignUpStateFailure(e.toString());
      }
    }
  }
}

final signUpStateNotifier = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(ref),
);
