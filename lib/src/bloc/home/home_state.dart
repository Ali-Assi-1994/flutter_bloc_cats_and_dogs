import 'package:flutter/foundation.dart' show immutable;

@immutable
class HomeState {
  final int selectedTab;

  const HomeState({
    required this.selectedTab,
  });
}
