import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/route_names.dart';
import '../../../logic/theme/theme_bloc.dart';
import '../../../logic/theme/theme_event.dart';
import '../../../logic/theme/theme_state.dart';
import '../../../logic/locale/locale_bloc.dart';
import '../../../logic/locale/locale_state.dart';

/// AppNavigationDrawer - Menu lateral moderno
class AppNavigationDrawer extends StatelessWidget {
  final String currentRoute;

  const AppNavigationDrawer({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          // Header com gradiente
          _buildHeader(context, theme),

          // Menu items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: AppTheme.space8),

                // Seção: Entities
                _buildSectionTitle(context, 'Entities'),

                _buildMenuItem(
                  context: context,
                  icon: Icons.description_outlined,
                  selectedIcon: Icons.description,
                  title: 'Items',
                  subtitle: 'Manage your items',
                  route: RouteNames.items,
                  color: Colors.blue,
                ),

                const Divider(height: AppTheme.space32),

                // Seção: Settings
                _buildSectionTitle(context, 'Configuration'),

                _buildMenuItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'App preferences',
                  route: RouteNames.settings,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),

          // Footer com theme toggle
          _buildFooter(context, theme),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppTheme.space16),
              Text(
                'Flutter CRUD',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.space4),
              Text(
                'Master-Detail Architecture',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.space16,
        AppTheme.space8,
        AppTheme.space16,
        AppTheme.space8,
      ),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required String subtitle,
    required String route,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isSelected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.space8,
        vertical: AppTheme.space4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.pop();
            context.go(route);
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          child: AnimatedContainer(
            duration: AppTheme.durationMedium,
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppTheme.space16,
                vertical: AppTheme.space4,
              ),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  color: color,
                  size: 22,
                ),
              ),
              title: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? theme.colorScheme.primary : null,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: theme.textTheme.bodySmall,
              ),
              trailing: isSelected
                  ? Icon(
                Icons.chevron_right,
                color: theme.colorScheme.primary,
              )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Theme toggle
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isDark = state is ThemeLoaded && state.isDark;

                return InkWell(
                  onTap: () {
                    context.read<ThemeBloc>().add(
                      const ToggleThemeEvent(),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  child: Container(
                    padding: const EdgeInsets.all(AppTheme.space8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusSmall,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isDark ? Icons.light_mode : Icons.dark_mode,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: AppTheme.space8),
                        Text(
                          isDark ? 'Light' : 'Dark',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Version
            Text(
              'v1.0.0',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}