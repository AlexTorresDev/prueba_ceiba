import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_ceiba/presentation/blocs/post/post_bloc.dart';
import 'package:prueba_ceiba/presentation/blocs/post/post_event.dart';
import 'package:prueba_ceiba/presentation/blocs/post/post_state.dart';
import 'package:prueba_ceiba/presentation/blocs/post_user/post_user_bloc.dart';
import 'package:prueba_ceiba/presentation/blocs/post_user/post_user_event.dart';
import 'package:prueba_ceiba/presentation/blocs/post_user/post_user_state.dart';
import 'package:prueba_ceiba/presentation/pages/post/widgets/post_card.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    Key? key,
    @PathParam() required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    context.read<PostBloc>().add(OnGetAll(widget.id));
    context.read<PostUserBloc>().add(OnGetUser(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba de ingreso'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const _User(),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Lista de publicaciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PostHasData) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    primary: true,
                    shrinkWrap: false,
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return PostCard(post: post);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                );
              } else if (state is PostError) {
                return Text('Error: ${state.message}');
              } else {
                return const Text('No data');
              }
            },
          ),
        ],
      ),
    );
  }
}

class _User extends StatelessWidget {
  const _User({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostUserBloc, PostUserState>(
      builder: (context, state) {
        if (state is PostUserHasData) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${state.user.name}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Phone: ${state.user.phone}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Email: ${state.user.email}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
