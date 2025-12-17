import 'package:equatable/equatable.dart';

/// ThemeEvent - Eventos de tema
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();
}

/// ToggleThemeEvent - Alternar entre light/dark
final class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();

  @override
  List<Object?> get props => [];
}

/// LoadSavedThemeEvent - Carregar tema salvo
final class LoadSavedThemeEvent extends ThemeEvent {
  const LoadSavedThemeEvent();

  @override
  List<Object?> get props => [];
}

/// SetThemeEvent - Definir tema específico
final class SetThemeEvent extends ThemeEvent {
  final bool isDark;

  const SetThemeEvent({required this.isDark});

  @override
  List<Object?> get props => [isDark];
}