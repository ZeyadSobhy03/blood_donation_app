import 'package:flutter/material.dart'; // Required for Locale
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';

sealed class LanguageEvent {}

class InitializeLanguageEvent extends LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final String languageCode;

  ChangeLanguageEvent({required this.languageCode});
}

class LanguageState {
  final Locale locale;

  const LanguageState({required this.locale});
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _languageBox = 'language_box';
  static const String _languageKey = 'app_language';

  late Box<String> _languageHiveBox;

  LanguageBloc() : super(const LanguageState(locale: Locale('ar'))) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<InitializeLanguageEvent>(_onInitializeLanguage);
  }

  Future<void> _initializeHiveBox() async {
    if (!Hive.isBoxOpen(_languageBox)) {
      _languageHiveBox = await Hive.openBox<String>(_languageBox);
    } else {
      _languageHiveBox = Hive.box<String>(_languageBox);
    }
  }

  Future<void> _onInitializeLanguage(
      InitializeLanguageEvent event,
      Emitter<LanguageState> emit,
      ) async {
    await _initializeHiveBox();

    final savedLanguage = _languageHiveBox.get(_languageKey, defaultValue: 'ar');
    final locale = Locale(savedLanguage ?? 'ar');

    emit(LanguageState(locale: locale));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event,
      Emitter<LanguageState> emit,
      ) async {
    await _initializeHiveBox();

    await _languageHiveBox.put(_languageKey, event.languageCode);

    final newLocale = Locale(event.languageCode);
    emit(LanguageState(locale: newLocale));
  }
}