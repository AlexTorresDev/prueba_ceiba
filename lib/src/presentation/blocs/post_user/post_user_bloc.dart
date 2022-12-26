import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prueba_ceiba/src/core/utils/transformer.dart';
import 'package:prueba_ceiba/src/domain/usecases/get_user.dart';
import 'package:prueba_ceiba/src/presentation/blocs/post_user/post_user_event.dart';
import 'package:prueba_ceiba/src/presentation/blocs/post_user/post_user_state.dart';

class PostUserBloc extends Bloc<PostUserEvent, PostUserState> {
  final GetUser getUser;

  PostUserBloc(this.getUser) : super(UserEmpty()) {
    on<OnGetUser>(
      (event, emit) async {
        final id = event.id;

        emit(UserLoading());

        final result = await getUser.getById(id);

        result.fold(
          (failure) {
            emit(UserError(failure.message));
          },
          (data) {
            emit(PostUserHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
