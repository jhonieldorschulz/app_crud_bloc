import 'package:app_crud_bloc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/locale/locale_bloc.dart';
import '../../../logic/locale/locale_event.dart';
import '../../../logic/locale/locale_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.language.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])),
          ),
          BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, state) {
              Locale current = const Locale('en');
              if (state is LocaleChanged) current = state.locale;

              return ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.selectLanguage),
                subtitle: Text(_getLocaleName(current)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLanguageDialog(context, current),
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.about.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(l10n.version),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(l10n.developer),
            subtitle: const Text('Flutter CRUD'),
          ),
        ],
      ),
    );
  }

  String _getLocaleName(Locale locale) {
    return switch (locale.languageCode) {
      'en' => 'English',
      'pt' => 'Português',
      'es' => 'Español',
      _ => locale.languageCode,
    };
  }

  void _showLanguageDialog(BuildContext context, Locale current) {
    final l10n = AppLocalizations.of(context)!;
    final locales = const [Locale('en'), Locale('pt'), Locale('es')];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.selectLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: locales.map((locale) {
            return RadioListTile<Locale>(
              value: locale,
              groupValue: current,
              title: Text(_getLocaleName(locale)),
              onChanged: (value) {
                if (value != null) {
                  context.read<LocaleBloc>().add(ChangeLocaleEvent(locale: value));
                  Navigator.pop(dialogContext);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}