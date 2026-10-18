enum SessionStatus { active, signingOut, signedOut, failure }

/// Single state of the session of the signed in user.
class SessionState {
  final SessionStatus status;
  final String? errorMessage;

  const SessionState({this.status = SessionStatus.active, this.errorMessage});

  SessionState copyWith({SessionStatus? status, String? errorMessage}) {
    return SessionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'SessionState(status: ${status.name}, error: $errorMessage)';
}
