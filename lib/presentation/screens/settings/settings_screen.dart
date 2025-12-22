import 'package:app_crud_bloc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme.dart';
import '../../../logic/locale/locale_bloc.dart';
import '../../../logic/locale/locale_event.dart';
import '../../../logic/locale/locale_state.dart';
import '../../../logic/theme/theme_bloc.dart';
import '../../../logic/theme/theme_event.dart';
import '../../../logic/theme/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.space16),
        children: [
          // ========== APARÊNCIA ==========
          _SectionHeader(title: l10n.appearance),

          // Theme Toggle
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              final isDark = state is ThemeLoaded && state.isDark;

              return Card(
                child: SwitchListTile(
                  value: isDark,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(
                      const ToggleThemeEvent(),
                    );
                  },
                  title: Text(l10n.darkMode),
                  subtitle: Text(
                    isDark ? 'Enabled' : 'Disabled',
                    style: theme.textTheme.bodySmall,
                  ),
                  secondary: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: theme.colorScheme.primary,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: AppTheme.space24),

          // ========== IDIOMA ==========
          _SectionHeader(title: l10n.language),

          BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, state) {
              Locale current = const Locale('en');
              if (state is LocaleChanged) current = state.locale;

              return Card(
                child: ListTile(
                  leading: Icon(
                    Icons.language,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(l10n.selectLanguage),
                  subtitle: Text(
                    _getLocaleName(current),
                    style: theme.textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showLanguageDialog(context, current),
                ),
              );
            },
          ),

          const SizedBox(height: AppTheme.space24),

          // ========== SOBRE ==========
          _SectionHeader(title: l10n.about),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(l10n.version),
                  subtitle: const Text('1.0.0'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.code,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(l10n.developer),
                  subtitle: const Text('Flutter CRUD Pro'),
                ),
              ],
            ),
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
                  context.read<LocaleBloc>().add(
                    ChangeLocaleEvent(locale: value),
                  );
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

/// _SectionHeader - Header de seção
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppTheme.space8,
        bottom: AppTheme.space12,
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}