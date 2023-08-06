import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

   @override
  Size get preferredSize => Size.fromHeight(height);
  
  @override
  Widget build(BuildContext context) {
        return AppBar(
      leading: IconButton(onPressed: () => context.go('/'), icon: const Icon(Icons.list)),
      title: Title(color: Colors.white, child: const Text('TCG Calculator')),
      backgroundColor: Colors.deepPurple,
      centerTitle: true,
    );
  }
}