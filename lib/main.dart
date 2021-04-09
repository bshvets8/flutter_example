import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/cubit.dart';
import 'package:flutter_cubit/domain/data_providers/data_providers.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:http/http.dart';

import 'posts_app.dart';

void main() {
  final client = Client();
  final webApi = WebAPI(client);
  final jsonPlaceholderDataProvider = JsonPlaceholderWebDataProvider(webApi);
  final inMemoryDataProvider = InMemoryDataProvider();

  final postsRepository = PostsRepositoryImpl(
    webDataProvider: jsonPlaceholderDataProvider,
    localDataProvider: inMemoryDataProvider,
  );

  final commentsRepository = CommentsRepositoryImpl(
    webDataProvider: jsonPlaceholderDataProvider,
    localDataProvider: inMemoryDataProvider,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostsRepository>( // TODO: Make non-singleton
          create: (context) => postsRepository,
        ),
        RepositoryProvider<CommentsRepository>(
          create: (context) => commentsRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PostsListCubit>( // TODO: Provide only on-purpose
            create: (_) => PostsListCubit(postsRepository: postsRepository),
          ),
          BlocProvider<PostsListSelectionCubit>(
            create: (_) => PostsListSelectionCubit(),
          ),
          BlocProvider<PostDetailsCubit>(
            create: (_) => PostDetailsCubit(postsRepository: postsRepository),
          ),
          BlocProvider<CommentsCubit>(
            create: (_) =>
                CommentsCubit(commentsRepository: commentsRepository),
          )
        ],
        child: PostsApp(),
      ),
    ),
  );
}
