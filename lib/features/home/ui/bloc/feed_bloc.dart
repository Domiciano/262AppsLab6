import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles_auth/features/auth/domain/usecases/get_my_profile_usecase.dart';
import 'package:moviles_auth/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_event.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_state.dart';

/// Loads the profile and the wall, toggles likes and signs out.
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  static const pageSize = 10;
  final GetMyProfileUseCase _getMyProfile = GetMyProfileUseCase();
  final SignOutUseCase _signOut = SignOutUseCase();

  FeedBloc() : super(const FeedState()) {
    on<ProfileRequested>(_onProfileRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<FeedStarted>(_onStarted);
    on<FeedMoreRequested>(_onMoreRequested);
    on<FeedLikeToggled>(_onLikeToggled);
  }

  Future<void> _onStarted(FeedStarted event, Emitter<FeedState> emit) async {
    debugPrint('FeedBloc recibió $event');
  }

  Future<void> _onMoreRequested(
    FeedMoreRequested event,
    Emitter<FeedState> emit,
  ) async {
    debugPrint('FeedBloc recibió $event');
  }

  Future<void> _onLikeToggled(
    FeedLikeToggled event,
    Emitter<FeedState> emit,
  ) async {
    debugPrint('FeedBloc recibió $event');
  }

  Future<void> _onProfileRequested(
    ProfileRequested event,
    Emitter<FeedState> emit,
  ) async {
    try {
      final profile = await _getMyProfile();
      emit(state.copyWith(profile: profile));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FeedStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<FeedState> emit,
  ) async {
    await _signOut();
    emit(state.copyWith(signedOut: true));
  }
}
