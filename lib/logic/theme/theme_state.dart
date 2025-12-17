import 'package:equatable/equatable.dart';

/// ThemeState - Estado do tema
sealed class ThemeState extends Equatable {
  const ThemeState();
}

/// ThemeInitial - Estado inicial
final class ThemeInitial extends ThemeState {
  const ThemeInitial();

  @override
  List<Object?> get props => [];
}

/// ThemeLoaded - Tema carregado
final class ThemeLoaded extends ThemeState {
  final bool isDark;

  const ThemeLoaded({required this.isDark});

  @override
  List<Object?> get props => [isDark];
}