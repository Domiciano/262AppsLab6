import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/compose/ui/bloc/compose_bloc.dart';
import 'package:moviles_auth/features/compose/ui/bloc/compose_event.dart';
import 'package:moviles_auth/features/compose/ui/screens/compose_screen.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_bloc.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_event.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_state.dart';
import 'package:moviles_auth/features/home/ui/pages/feed_page.dart';
import 'package:moviles_auth/features/home/ui/screens/home_screen.dart';
import 'package:moviles_auth/features/posts/domain/entities/post.dart';

class _FakeFeedBloc extends Bloc<FeedEvent, FeedState> implements FeedBloc {
  _FakeFeedBloc() : super(const FeedState()) {
    on<ProfileRequested>(
      (event, emit) => emit(state.copyWith(profile: _profile)),
    );
    on<FeedStarted>((event, emit) {});
    on<SignOutRequested>(
      (event, emit) => emit(state.copyWith(signedOut: true)),
    );
  }
}

class _EventRecorder extends BlocObserver {
  final events = <Object?>[];

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    events.add(event);
  }
}

Post _post(String id, {int likes = 0, bool mine = false}) => Post(
  id: id,
  content: 'Contenido de $id',
  createdAt: DateTime(2026, 10, 18, 10, 5),
  authorUsername: 'ana.dev',
  authorName: 'Ana Gómez',
  likeCount: likes,
  likedByMe: mine,
);

const _profile = Profile(
  id: 'u1',
  username: 'ana.dev',
  fullName: 'Ana Gómez',
  email: 'ana@icesi.edu.co',
);

void main() {
  test('Post.copyWith only changes the likes', () {
    final liked = _post('p1', likes: 2).copyWith(likeCount: 3, likedByMe: true);
    expect(liked.likeCount, 3);
    expect(liked.likedByMe, isTrue);
    expect(liked.content, 'Contenido de p1');
  });

  test('FeedState.copyWith keeps what it is not told to change', () {
    final state = const FeedState().copyWith(posts: [_post('p1')], page: 1);
    final loading = state.copyWith(status: FeedStatus.loading);
    expect(loading.posts, hasLength(1));
    expect(loading.page, 1);
    expect(loading.hasMore, isTrue);
  });

  testWidgets('FeedPage shows the posts and reports likes and more', (
    tester,
  ) async {
    Post? liked;
    var more = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FeedPage(
            posts: [_post('p1'), _post('p2', likes: 4, mine: true)],
            hasMore: true,
            isLoading: false,
            onLoadMore: () => more++,
            onLike: (post) => liked = post,
          ),
        ),
      ),
    );
    expect(find.text('Contenido de p2'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byIcon(Icons.favorite_border));
    expect(liked?.id, 'p1');
    await tester.tap(find.text('Mostrar más'));
    expect(more, 1);
  });

  testWidgets('HomeScreen sends events to FeedBloc and switches pages', (
    tester,
  ) async {
    final recorder = _EventRecorder();
    Bloc.observer = recorder;
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (_) => BlocProvider<FeedBloc>(
            create: (_) => _FakeFeedBloc(),
            child: const HomeScreen(),
          ),
          '/login': (_) => const Scaffold(body: Text('login')),
        },
      ),
    );
    await tester.pump();
    expect(recorder.events, [isA<ProfileRequested>(), isA<FeedStarted>()]);
    expect(find.text('Todavía no hay posts'), findsOneWidget);

    await tester.tap(find.text('Perfil').last);
    await tester.pump();
    expect(find.text('@ana.dev'), findsOneWidget);
    expect(find.text('Aún no has publicado'), findsOneWidget);

    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();
    expect(find.text('login'), findsOneWidget);
  });

  testWidgets('ComposeScreen counts characters and sends the text', (
    tester,
  ) async {
    final recorder = _EventRecorder();
    Bloc.observer = recorder;
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => ComposeBloc(),
          child: const ComposeScreen(),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), 'Hola muro');
    await tester.pump();
    expect(find.text('9/280'), findsOneWidget);
    await tester.tap(find.text('Publicar'));
    await tester.pump();
    final event = recorder.events.single as ComposeSubmitted;
    expect(event.content, 'Hola muro');
  });
}
