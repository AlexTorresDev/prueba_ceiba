import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prueba_ceiba/core/utils/transformer.dart';
import 'package:prueba_ceiba/domain/usecases/get_post_list.dart';
import 'package:prueba_ceiba/presentation/blocs/post/post_event.dart';
import 'package:prueba_ceiba/presentation/blocs/post/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostList getPostList;

  PostBloc(this.getPostList) : super(PostEmpty()) {
    on<OnGetAll>(
      (event, emit) async {
        final userId = event.userId;

        emit(PostLoading());

        final result = await getPostList.call(userId);

        result.fold(
          (failure) {
            emit(PostError(failure.message));
          },
          (data) {
            emit(PostHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
