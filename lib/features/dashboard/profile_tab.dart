import 'package:flutter/material.dart';
import 'package:flutter_project/features/authentication/authentication_view.dart';
import 'package:flutter_project/services/user_cache_service.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/utilities/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userCacheProvider).user;
    return user == null
        ? const Center(
            child: text('No user available'),
          )
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 48.0,
                  backgroundImage: NetworkImage(
                    user.image,
                  ),
                ),
                16.verticalSpacer,
                ...user
                    .toDisplayMap()
                    .entries
                    .map(
                      (e) => Column(
                        children: [
                          ListTile(
                            title: text(e.key.capitalize),
                            subtitle: text(e.value),
                          ),
                          const Divider(),
                        ],
                      ),
                    )
                    .toList(),
                SizedBox(
                  height: 54,
                  width: context.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      //logout
                      ref.read(userCacheProvider).deleteUser();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AuthenticationView.routeName,
                        (route) => false,
                      );
                    },
                    child: text(
                      'Logout',
                      size: context.textTheme.headlineSmall?.fontSize,
                      fontweight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
