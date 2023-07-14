import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../network/auth_exception.dart';
import '../../network/provider/auth_provider.dart';
import 'login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  LoginNotifier(this.ref) : super(const LoginStateInitial());

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
            email,
            password,
          );
      state = const LoginStateSuccess();
    } catch (e) {
      if (e is AuthException) {
        state = LoginStateFailure(e.message.toString());
      } else {
        state = LoginStateFailure(e.toString());
      }
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}

final loginStateNotifier = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(ref),
);
