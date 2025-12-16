import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class LocaleState extends Equatable {
  const LocaleState();
}

final class LocaleInitial extends LocaleState {
  const LocaleInitial();
  @override
  List<Object?> get props => [];
}

final class LocaleChanged extends LocaleState {
  final Locale locale;
  const LocaleChanged({required this.locale});
  @override
  List<Object?> get props => [locale];
}