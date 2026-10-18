import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_bloc.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_event.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_state.dart';
import 'package:moviles_auth/features/home/ui/bloc/session_bloc.dart';
import 'package:moviles_auth/features/home/ui/bloc/session_event.dart';
import 'package:moviles_auth/features/home/ui/bloc/session_state.dart';
import 'package:moviles_auth/features/home/ui/pages/feed_page.dart';
import 'package:moviles_auth/features/home/ui/pages/profile_page.dart';

/// Hosts FeedPage and ProfilePage behind a BottomNavigationBar.
class HomeScreen extends StatefulWidget {
  final Profile profile;

  const HomeScreen({super.key, required this.profile});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(FeedStarted());
  }

  Future<void> _openCompose() async {
    final published = await Navigator.pushNamed(context, '/compose');
    if (published == true && mounted) {
      context.read<FeedBloc>().add(FeedStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        if (state.status == SessionStatus.signedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(_index == 0 ? 'Muro' : 'Perfil')),
        body: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            final bloc = context.read<FeedBloc>();
            if (_index == 1) {
              return ProfilePage(
                profile: widget.profile,
                posts: state.myPosts,
                onLike: (post) => bloc.add(FeedLikeToggled(post)),
                onSignOut: () =>
                    context.read<SessionBloc>().add(SignOutRequested()),
              );
            }
            return FeedPage(
              posts: state.posts,
              hasMore: state.hasMore,
              isLoading: state.status == FeedStatus.loading,
              onLoadMore: () => bloc.add(FeedMoreRequested()),
              onLike: (post) => bloc.add(FeedLikeToggled(post)),
            );
          },
        ),
        floatingActionButton: _index == 0
            ? FloatingActionButton(
                onPressed: () => _openCompose(),
                child: const Icon(Icons.edit),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (index) => setState(() => _index = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Muro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
