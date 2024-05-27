import 'package:flutter/material.dart';
import 'package:mirror_wall/provider/mirror_wall_provider.dart';
import 'package:mirror_wall/view/google_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleProvider(),)
      ], builder: (context, child) => const MirrorWall()));
}

class MirrorWall extends StatelessWidget {
  const MirrorWall({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleScreen(),
    );
  }
}
