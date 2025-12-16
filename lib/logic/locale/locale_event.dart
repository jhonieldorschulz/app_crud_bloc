import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();
}

final class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;
  const ChangeLocaleEvent({required this.locale});
  @override
  List<Object?> get props => [locale];
}

final class LoadSavedLocaleEvent extends LocaleEvent {
  const LoadSavedLocaleEvent();
  @override
  List<Object?> get props => [];
}