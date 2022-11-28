import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prueba_ceiba/core/utils/transformer.dart';
import 'package:prueba_ceiba/domain/usecases/get_user.dart';
import 'package:prueba_ceiba/domain/usecases/get_user_list.dart';
import 'package:prueba_ceiba/presentation/blocs/user/user_event.dart';
import 'package:prueba_ceiba/presentation/blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserList getUserList;
  final GetUser getUser;

  UserBloc(this.getUserList, this.getUser) : super(UserEmpty()) {
    on<OnGetAll>(
      (event, emit) async {
        emit(UserLoading());

        final result = await getUserList.call();

        result.fold(
          (failure) {
            emit(UserError(failure.message));
          },
          (data) {
            emit(UserHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnSearch>(
      (event, emit) async {
        final query = event.query;

        emit(UserLoading());

        final result = await getUser.call(query);

        result.fold(
          (failure) {
            emit(UserError(failure.message));
          },
          (data) {
            emit(UserHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
