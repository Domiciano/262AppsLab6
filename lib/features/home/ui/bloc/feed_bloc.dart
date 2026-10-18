import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_event.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_state.dart';

/// Loads the wall page by page and toggles likes.
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  static const pageSize = 10;

  FeedBloc() : super(const FeedState()) {
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
}
