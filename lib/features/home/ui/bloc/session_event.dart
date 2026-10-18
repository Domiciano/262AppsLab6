/// Something the home screen asks the SessionBloc to do.
abstract class SessionEvent {}

/// The user pressed Cerrar sesión.
class SignOutRequested extends SessionEvent {
  @override
  String toString() => 'SignOutRequested()';
}
