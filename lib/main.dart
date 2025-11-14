import 'package:cryptoapp/screens/home.dart';
import 'package:cryptoapp/theme.dart';
import 'package:cryptoapp/provider/coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();      // ← correct initialization
  await dotenv.load(fileName: ".env");

  await Hive.openBox('cachedData');  // ← you must create your box here

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoinProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: Web3Theme.darkTheme ,
        home: const HomeScreen(),
      ),
    );
  }
}
