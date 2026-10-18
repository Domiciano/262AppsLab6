import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles_auth/features/compose/ui/bloc/compose_event.dart';
import 'package:moviles_auth/features/compose/ui/bloc/compose_state.dart';

/// Publishes the text written in the compose screen.
class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  ComposeBloc() : super(const ComposeState()) {
    on<ComposeSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    ComposeSubmitted event,
    Emitter<ComposeState> emit,
  ) async {}
}
