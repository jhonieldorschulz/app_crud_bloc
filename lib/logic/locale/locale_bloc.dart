import 'package:app_crud_bloc/logic/locale/locale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale_event.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  static const String _key = 'locale';
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('pt'),
    Locale('es'),
  ];

  LocaleBloc() : super(const LocaleInitial()) {
    on<LocaleEvent>((event, emit) async {
      await switch (event) {
        ChangeLocaleEvent() => _onChange(event, emit),
        LoadSavedLocaleEvent() => _onLoad(emit),
      };
    });
  }

  Future<void> _onChange(ChangeLocaleEvent event, Emitter<LocaleState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, event.locale.languageCode);
    emit(LocaleChanged(locale: event.locale));
  }

  Future<void> _onLoad(Emitter<LocaleState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null) {
      emit(LocaleChanged(locale: Locale(code)));
    } else {
      emit(const LocaleChanged(locale: Locale('en')));
    }
  }
}