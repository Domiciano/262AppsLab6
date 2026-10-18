import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviles_auth/components/error_message.dart';
import 'package:moviles_auth/components/primary_button.dart';
import 'package:moviles_auth/features/compose/ui/bloc/compose_bloc.dart';
import 'package:moviles_auth/features/compose/ui/bloc/compose_event.dart';
import 'package:moviles_auth/features/compose/ui/bloc/compose_state.dart';
import 'package:moviles_auth/theme/app_theme.dart';

/// Writes a new post and goes back to the wall once it is published.
class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() {
    return _ComposeScreenState();
  }
}

class _ComposeScreenState extends State<ComposeScreen> {
  static const maxLength = 280;
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final length = _contentController.text.length;
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo post')),
      body: SafeArea(
        child: BlocListener<ComposeBloc, ComposeState>(
          listener: (context, state) {
            if (state.status == ComposeStatus.success) {
              Navigator.pop(context, true);
            }
          },
          child: BlocBuilder<ComposeBloc, ComposeState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _contentController,
                      minLines: 5,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        hintText: '¿Qué estás pensando?',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$length/$maxLength',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: length > maxLength
                            ? AppColors.error
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state.status == ComposeStatus.failure &&
                        state.errorMessage != null) ...[
                      ErrorMessage(message: state.errorMessage!),
                      const SizedBox(height: 16),
                    ],
                    PrimaryButton(
                      label: 'Publicar',
                      isLoading: state.status == ComposeStatus.loading,
                      onPressed: () => context.read<ComposeBloc>().add(
                        ComposeSubmitted(_contentController.text),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
