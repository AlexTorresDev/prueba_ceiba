import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_ceiba/presentation/blocs/user/user_bloc.dart';
import 'package:prueba_ceiba/presentation/blocs/user/user_event.dart';
import 'package:prueba_ceiba/presentation/blocs/user/user_state.dart';
import 'package:prueba_ceiba/presentation/pages/home/widgets/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserBloc>().add(const OnGetAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba de ingreso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar usuario',
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<UserBloc>().add(const OnGetAll());
                } else {
                  context.read<UserBloc>().add(OnSearch(value));
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UserHasData) {
                    return ListView.separated(
                      primary: true,
                      shrinkWrap: false,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserCard(user: user);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    );
                  } else if (state is UserError) {
                    return Text(state.message);
                  } else {
                    return const Text('No data');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
