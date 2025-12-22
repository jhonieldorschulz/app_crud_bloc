import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

/// ThemeBloc - Gerenciador de tema
///
/// Responsabilidades:
/// 1. Alternar entre light/dark mode
/// 2. Salvar preferência em SharedPreferences
/// 3. Carregar tema ao iniciar app
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _key = 'theme_is_dark';

  ThemeBloc() : super(const ThemeInitial()) {
    on<ThemeEvent>((event, emit) async {
      await switch (event) {
        ToggleThemeEvent() => _onToggle(emit),
        LoadSavedThemeEvent() => _onLoad(emit),
        SetThemeEvent() => _onSet(event, emit),
      };
    });
  }

  /// Alternar tema
  Future<void> _onToggle(Emitter<ThemeState> emit) async {
    final currentState = state;
    
    // Se ainda não foi carregado, carregar primeiro
    bool currentIsDark = false;
    if (currentState is ThemeLoaded) {
      currentIsDark = currentState.isDark;
    } else {
      // Carregar do SharedPreferences se ainda não foi carregado
      final prefs = await SharedPreferences.getInstance();
      currentIsDark = prefs.getBool(_key) ?? false;
    }

    final newIsDark = !currentIsDark;

    // Salvar preferência
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, newIsDark);

    // Emitir novo estado
    emit(ThemeLoaded(isDark: newIsDark));
  }

  /// Carregar tema salvo
  Future<void> _onLoad(Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? false; // Default: light

    emit(ThemeLoaded(isDark: isDark));
  }

  /// Definir tema específico
  Future<void> _onSet(SetThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, event.isDark);

    emit(ThemeLoaded(isDark: event.isDark));
  }
}