// lib/providers/counter_provider.dart

import 'package:flutter/foundation.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  // getter public
  int get counter => _counter;

  // méthode pour incrémenter
  void increment() {
    _counter++;
    notifyListeners(); // ⚠️ notifie les widgets écoutant
  }
}
