import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../providers/theme_provider.dart';

import '../../../blocs/header/header_bloc.dart';
import '../../../blocs/header/header_event.dart';
import '../../../blocs/transactions/transactions_bloc.dart';
import '../../../blocs/transactions/transactions_event.dart';

import '../widgets/header_section.dart';
import '../widgets/transactions_section.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initNotifications();
    //sabner a un topic all
    FirebaseMessaging.instance.subscribeToTopic("all");
    // ⏳ attendre que le widget soit monté
    Future.microtask(() {
      context.read<HeaderBloc>().add(HeaderLoadAccounts());
      context.read<TransactionsBloc>().add(TransactionsLoadRequested(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank App"),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            HeaderSection(),
            Expanded(child: TransactionsSection()),
          ],
        ),
      ),
    );
  }

  Future<void> _initNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Permission Android 13+
    await messaging.requestPermission();

    // Token (très important pour le TP)
    final token = await messaging.getToken();
    print("🔥 FCM TOKEN = $token");

    // Écoute quand app ouverte
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.notification?.title ?? "Nouvelle notification"),
        ),
      );
    });
  }
}
