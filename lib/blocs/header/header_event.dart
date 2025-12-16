abstract class HeaderEvent {}

class HeaderCurrentPageChanged extends HeaderEvent {
  final int newIndex;
  HeaderCurrentPageChanged(this.newIndex);
}

class HeaderToggleHidden extends HeaderEvent {}

class HeaderLoadAccounts extends HeaderEvent {}
