import 'package:app1/app/app.dart';
import 'package:app1/chat/cubit/chat_cubit.dart';
import 'package:chat_repository/chat_repository.dart' as chat;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go("/home"),
        ),
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Text("Samuel Chandra"),
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFFDEDEDE),
            width: 1,
          ),
        ),
      ),
      body: StreamBuilder<chat.Room>(
          stream: chat.ChatRepository().room(
              roomId: context.read<ChatCubit>().state.roomId,
              uid: context.read<AppBloc>().state.user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingAnimationWidget.newtonCradle(
                color: const Color(0xFF000000),
                size: 20,
              );
            }
            return StreamBuilder<List<chat.Message>>(
              initialData: const [],
              stream: chat.ChatRepository().messages(snapshot.data!),
              builder: (context, snapshot) => Text("daw"),
            );
          }),
    );
  }
}
