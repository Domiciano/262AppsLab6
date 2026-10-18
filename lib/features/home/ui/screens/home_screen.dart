import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviles_auth/features/home/ui/bloc/feed_bloc.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_event.dart';
import 'package:moviles_auth/features/home/ui/bloc/feed_state.dart';
import 'package:moviles_auth/features/home/ui/pages/feed_page.dart';
import 'package:moviles_auth/features/home/ui/pages/profile_page.dart';

/// Hosts FeedPage and ProfilePage behind a BottomNavigationBar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<FeedBloc>();
    bloc.add(ProfileRequested());
    bloc.add(FeedStarted());
  }

  Future<void> _openCompose() async {
    final published = await Navigator.pushNamed(context, '/compose');
    if (published == true && mounted) {
      context.read<FeedBloc>().add(FeedStarted());
    }
  }

  Widget _page(FeedState state) {
    final bloc = context.read<FeedBloc>();
    if (_index == 1) {
      final profile = state.profile;
      if (profile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return ProfilePage(
        profile: profile,
        posts: state.myPosts,
        onLike: (post) => bloc.add(FeedLikeToggled(post)),
        onSignOut: () => bloc.add(SignOutRequested()),
      );
    }
    return FeedPage(
      posts: state.posts,
      hasMore: state.hasMore,
      isLoading: state.status == FeedStatus.loading,
      onLoadMore: () => bloc.add(FeedMoreRequested()),
      onLike: (post) => bloc.add(FeedLikeToggled(post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedBloc, FeedState>(
      listenWhen: (previous, current) =>
          !previous.signedOut && current.signedOut,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(_index == 0 ? 'Muro' : 'Perfil')),
        body: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) => _page(state),
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
