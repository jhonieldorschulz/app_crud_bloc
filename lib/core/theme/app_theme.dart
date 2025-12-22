import 'package:flutter/material.dart';

/// AppTheme - Tema centralizado do aplicativo
///
/// Contém TODAS as constantes de design para garantir consistência visual
/// em todo o aplicativo. Seguindo princípios de Design System.
///
/// Estrutura:
/// - Spacing: Espaçamentos padronizados (4, 8, 12, 16, 20, 24, 32)
/// - Padding: Padding interno de componentes
/// - Radius: Border radius de componentes
/// - Sizes: Tamanhos de ícones, imagens, etc
/// - Colors: Paleta de cores personalizada
/// - TextStyles: Estilos de texto customizados
/// - Themes: Temas Light e Dark completos
///
/// Uso:
/// ```dart
/// // Spacing
/// SizedBox(height: AppTheme.space16)
///
/// // Padding
/// Padding(padding: EdgeInsets.all(AppTheme.paddingMedium))
///
/// // Radius
/// BorderRadius.circular(AppTheme.radiusMedium)
///
/// // Colors
/// Container(color: AppTheme.primaryColor)
/// ```
class AppTheme {
  // Prevenir instanciação
  AppTheme._();

  // ========================================
  // SPACING (Espaçamentos)
  // ========================================

  /// Espaçamento extra pequeno: 4.0
  static const double space4 = 4.0;

  /// Espaçamento pequeno: 8.0
  static const double space8 = 8.0;

  /// Espaçamento médio-pequeno: 12.0
  static const double space12 = 12.0;

  /// Espaçamento médio: 16.0
  static const double space16 = 16.0;

  /// Espaçamento médio-grande: 20.0
  static const double space20 = 20.0;

  /// Espaçamento grande: 24.0
  static const double space24 = 24.0;

  /// Espaçamento extra grande: 32.0
  static const double space32 = 32.0;

  /// Espaçamento gigante: 48.0
  static const double space48 = 48.0;

  /// Espaçamento massivo: 64.0
  static const double space64 = 64.0;

  // ========================================
  // PADDING (Padding interno)
  // ========================================

  /// Padding extra pequeno: 4.0
  static const double paddingTiny = space4;

  /// Padding pequeno: 8.0
  static const double paddingSmall = space8;

  /// Padding médio: 16.0 (padrão)
  static const double paddingMedium = space16;

  /// Padding grande: 24.0
  static const double paddingLarge = space24;

  /// Padding extra grande: 32.0
  static const double paddingExtraLarge = space32;

  // ========================================
  // RADIUS (Border Radius)
  // ========================================

  /// Radius pequeno: 4.0
  static const double radiusSmall = 4.0;

  /// Radius médio: 8.0 (padrão)
  static const double radiusMedium = 8.0;

  /// Radius grande: 12.0
  static const double radiusLarge = 12.0;

  /// Radius extra grande: 16.0
  static const double radiusExtraLarge = 16.0;

  /// Radius circular completo: 999.0
  static const double radiusCircular = 999.0;

  // ========================================
  // SIZES (Tamanhos de componentes)
  // ========================================

  /// Tamanho de ícone pequeno: 16.0
  static const double iconSizeSmall = 16.0;

  /// Tamanho de ícone médio: 24.0 (padrão)
  static const double iconSizeMedium = 24.0;

  /// Tamanho de ícone grande: 32.0
  static const double iconSizeLarge = 32.0;

  /// Tamanho de ícone extra grande: 48.0
  static const double iconSizeExtraLarge = 48.0;

  /// Tamanho de avatar pequeno: 32.0
  static const double avatarSizeSmall = 32.0;

  /// Tamanho de avatar médio: 48.0
  static const double avatarSizeMedium = 48.0;

  /// Tamanho de avatar grande: 64.0
  static const double avatarSizeLarge = 64.0;

  /// Altura de botão: 48.0
  static const double buttonHeight = 48.0;

  /// Altura de campo de texto: 56.0
  static const double textFieldHeight = 56.0;

  /// Altura de AppBar: 56.0
  static const double appBarHeight = 56.0;

  // ========================================
  // ELEVATION (Elevação de sombras)
  // ========================================

  /// Elevação nenhuma: 0.0
  static const double elevationNone = 0.0;

  /// Elevação baixa: 2.0
  static const double elevationLow = 2.0;

  /// Elevação média: 4.0
  static const double elevationMedium = 4.0;

  /// Elevação alta: 8.0
  static const double elevationHigh = 8.0;

  /// Elevação extra alta: 16.0
  static const double elevationExtraHigh = 16.0;

  // ========================================
  // COLORS (Paleta de cores personalizada)
  // ========================================

  // Cores primárias
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color onPrimary = Colors.white;

  // Cores secundárias
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color onSecondary = Colors.black;

  // Cores de superfície
  static const Color backgroundColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  static const Color onBackground = Colors.black87;
  static const Color onSurface = Colors.black87;

  // Cores de erro
  static const Color errorColor = Color(0xFFB00020);
  static const Color onError = Colors.white;

  // Cores neutras
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Cores semânticas
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color infoColor = Color(0xFF2196F3);

  // Cores para entidades (usado em ícones/badges)
  static const Color itemsColor = Color(0xFF2196F3); // Azul
  static const Color productsColor = Color(0xFF4CAF50); // Verde
  static const Color ordersColor = Color(0xFFFF9800); // Laranja
  static const Color customersColor = Color(0xFF9C27B0); // Roxo

  // ========================================
  // DURATIONS (Durações de animação)
  // ========================================

  /// Duração rápida: 200ms
  static const Duration durationFast = Duration(milliseconds: 200);

  /// Duração média: 300ms (padrão)
  static const Duration durationMedium = Duration(milliseconds: 300);

  /// Duração lenta: 500ms
  static const Duration durationSlow = Duration(milliseconds: 500);

  // ========================================
  // LIGHT THEME (Tema Claro)
  // ========================================

  static ThemeData get lightTheme {
    return ThemeData(
      // Brilho
      brightness: Brightness.light,

      // Esquema de cores
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        primaryContainer: primaryVariant,
        secondary: secondaryColor,
        secondaryContainer: secondaryVariant,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onBackground: onBackground,
        onError: onError,
      ),

      // Cores primárias (legado)
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: elevationLow,
        centerTitle: false,
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        iconTheme: IconThemeData(color: onPrimary),
        titleTextStyle: TextStyle(
          color: onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: space8,
        ),
      ),

      // Botões elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          elevation: elevationLow,
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Botões de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Botões outlined
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Campos de texto
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: grey100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: paddingSmall,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        elevation: elevationMedium,
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: grey200,
        selectedColor: primaryColor,
        secondarySelectedColor: secondaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: paddingSmall,
          vertical: space4,
        ),
        labelStyle: const TextStyle(fontSize: 14),
        secondaryLabelStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),

      // Dialogs
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        elevation: elevationHigh,
      ),

      // BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLarge),
          ),
        ),
        elevation: elevationHigh,
      ),

      // Divisor
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
        color: grey300,
      ),

      // ListTile
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: space8,
        ),
      ),

      // IconTheme
      iconTheme: const IconThemeData(
        size: iconSizeMedium,
        color: onSurface,
      ),

      // Tipografia
      textTheme: const TextTheme(
        // Títulos
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),

        // Headlines
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),

        // Títulos
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),

        // Body
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: onSurface,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: onSurface,
        ),

        // Labels
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
      ),
    );
  }

  // ========================================
  // DARK THEME (Tema Escuro)
  // ========================================

  static ThemeData get darkTheme {
    return ThemeData(
      // Brilho
      brightness: Brightness.dark,

      // Esquema de cores
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        primaryContainer: primaryVariant,
        secondary: secondaryColor,
        secondaryContainer: secondaryVariant,
        surface: Color(0xFF121212),
        background: Color(0xFF121212),
        error: errorColor,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: onError,
      ),

      // Cores primárias (legado)
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF121212),

      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: elevationLow,
        centerTitle: false,
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: elevationLow,
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: space8,
        ),
      ),

      // Botões elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          elevation: elevationLow,
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Botões de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Botões outlined
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Campos de texto
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: paddingSmall,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        elevation: elevationMedium,
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF2C2C2C),
        selectedColor: primaryColor,
        secondarySelectedColor: secondaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: paddingSmall,
          vertical: space4,
        ),
        labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
        secondaryLabelStyle: const TextStyle(fontSize: 14, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),

      // Dialogs
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        elevation: elevationHigh,
      ),

      // BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLarge),
          ),
        ),
        elevation: elevationHigh,
      ),

      // Divisor
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
        color: Color(0xFF2C2C2C),
      ),

      // ListTile
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: space8,
        ),
      ),

      // IconTheme
      iconTheme: const IconThemeData(
        size: iconSizeMedium,
        color: Colors.white,
      ),

      // Tipografia (igual ao light, mas com cores brancas)
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white70,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
    );
  }
}