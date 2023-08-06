import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tcg_calculator/providers/route_providers.dart';
import 'package:go_router/go_router.dart';
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
    final GoRouter providerRouter = ref.watch(routeProvider);
    return MaterialApp.router(
      routerConfig: providerRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}