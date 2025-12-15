// lib/blocs/header/header_event.dart

abstract class HeaderEvent {}

// Event pour changer de page
class HeaderCurrentPageChanged extends HeaderEvent {
  final int newIndex;
  HeaderCurrentPageChanged(this.newIndex);
}

// Event pour alterner visibilité du solde
class HeaderToggleHidden extends HeaderEvent {}
