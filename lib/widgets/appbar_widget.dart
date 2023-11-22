import 'package:flutter/material.dart';

import '../style/colors.dart';

class AppBarMain extends StatelessWidget implements PreferredSize {
  final String title;
  final bool showBack;

  final List<Widget>? actions;

  const AppBarMain({super.key, required this.title, this.showBack = false, this.actions});

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColorPalette.primary,
      elevation: 6,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      title: Text(title),
    );
  }
}
