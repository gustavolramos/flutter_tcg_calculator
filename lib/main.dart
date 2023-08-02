import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tcg_calculator/widgets/app_bar.dart';
import 'package:flutter_tcg_calculator/widgets/floating_action_button.dart';
import 'package:flutter_tcg_calculator/widgets/list_of_decks.dart';
import 'firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(height: 150),
        floatingActionButton: CustomFloatingActionButton(),
        body: Center(
          child: CustomListView(),
        ),
      ),
    );
  }
}