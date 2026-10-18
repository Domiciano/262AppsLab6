enum ComposeStatus { initial, loading, success, failure }

/// Single state of the compose screen; status says which moment it is.
class ComposeState {
  final ComposeStatus status;
  final String? errorMessage;

  const ComposeState({this.status = ComposeStatus.initial, this.errorMessage});

  ComposeState copyWith({ComposeStatus? status, String? errorMessage}) {
    return ComposeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'ComposeState(status: ${status.name}, error: $errorMessage)';
  }
}
