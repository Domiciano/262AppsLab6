/// Something the compose screen asks the ComposeBloc to do.
abstract class ComposeEvent {}

/// The user pressed Publicar with this text.
class ComposeSubmitted extends ComposeEvent {
  final String content;

  ComposeSubmitted(this.content);

  @override
  String toString() {
    return "ComposeSubmitted('$content')";
  }
}
