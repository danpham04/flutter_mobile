import 'package:flutter/material.dart';
import 'package:flutter_mobile/provider/provider_home.dart';
import 'package:flutter_mobile/screens/app/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderHome(),
        ),
        
      ],
      child: const MyApp(),
    ),
  );
}