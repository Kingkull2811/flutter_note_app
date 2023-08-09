import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/screens/sign_up/sign_up_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpNotifier(this.ref) : super(const SignUpStateInitial());
}
