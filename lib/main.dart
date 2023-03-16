import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/ui/screens/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ProviderScope(
        child:  MaterialApp(
        title: 'Priueba app ',
        home: HomeScreen()
      ) 
    );
  }
}