import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles_auth/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:moviles_auth/features/home/ui/bloc/session_event.dart';
import 'package:moviles_auth/features/home/ui/bloc/session_state.dart';

/// Closes the session of the signed in user through SignOutUseCase.
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SignOutUseCase _signOut;

  SessionBloc(this._signOut) : super(const SessionState()) {
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<SessionState> emit,
  ) async {
    emit(state.copyWith(status: SessionStatus.signingOut));
    try {
      await _signOut();
      emit(state.copyWith(status: SessionStatus.signedOut));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: SessionStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
