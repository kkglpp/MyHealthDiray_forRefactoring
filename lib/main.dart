import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Archive/makedb_impl.dart';
import 'provider/navigationRoute.dart/navigation_provider.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized(); 
  // 데이터베이스 생성 및 초기화 하고 시작하자.
  MakeDBImpl dbImpl = MakeDBImpl();
  await dbImpl.initializeAllTables();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
