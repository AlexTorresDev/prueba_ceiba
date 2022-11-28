import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:prueba_ceiba/core/framework/colors.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name!,
              style: theme.textTheme.titleLarge?.copyWith(color: primaryColor),
            ),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  user.phone!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.email,
                  color: primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  user.email!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.router.pushNamed('/post/${user.id}'),
                child: Text(
                  'Ver publicaciones'.toUpperCase(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
