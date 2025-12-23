import 'package:flutter/material.dart';

/// AppTheme - Tema centralizado do aplicativo (MODERNIZADO)
///
/// Contém TODAS as constantes de design para garantir consistência visual
/// em todo o aplicativo. Seguindo princípios de Design System moderno.
///
/// Paleta: Indigo Modern (Clean & Professional)
/// Inspiração: Notion, Linear, Stripe, Vercel
///
/// Estrutura:
/// - Spacing: Espaçamentos padronizados (4, 8, 12, 16, 20, 24, 32)
/// - Padding: Padding interno de componentes
/// - Radius: Border radius de componentes
/// - Sizes: Tamanhos de ícones, imagens, etc
/// - Colors: Paleta moderna (Tailwind-inspired)
/// - TextStyles: Estilos de texto customizados
/// - Themes: Temas Light e Dark completos (Material 3)
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

  /// Radius médio: 8.0
  static const double radiusMedium = 8.0;

  /// Radius grande: 12.0 (padrão moderno)
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

  /// Elevação nenhuma: 0.0 (Flat Design)
  static const double elevationNone = 0.0;

  /// Elevação baixa: 1.0
  static const double elevationLow = 1.0;

  /// Elevação média: 2.0
  static const double elevationMedium = 2.0;

  /// Elevação alta: 4.0
  static const double elevationHigh = 4.0;

  /// Elevação extra alta: 8.0
  static const double elevationExtraHigh = 8.0;

  // ========================================
  // COLORS - INDIGO MODERN PALETTE
  // ========================================

  // Primary colors (Indigo vibrante)
  static const Color primaryColor = Color(0xFF6366F1); // Indigo-500
  static const Color primaryVariant = Color(0xFF4F46E5); // Indigo-600
  static const Color primaryLight = Color(0xFFEEF2FF); // Indigo-50
  static const Color primaryDark = Color(0xFF312E81); // Indigo-900
  static const Color onPrimary = Colors.white;

  // Secondary colors (Teal moderno)
  static const Color secondaryColor = Color(0xFF14B8A6); // Teal-500
  static const Color secondaryVariant = Color(0xFF0D9488); // Teal-600
  static const Color secondaryLight = Color(0xFFF0FDFA); // Teal-50
  static const Color secondaryDark = Color(0xFF134E4A); // Teal-900
  static const Color onSecondary = Colors.white;

  // Background colors (Light mode)
  static const Color backgroundColor = Color(0xFFFAFAFA); // Cinza quase branco
  static const Color surfaceColor = Colors.white;
  static const Color onBackground = Color(0xFF1F2937); // Gray-800
  static const Color onSurface = Color(0xFF1F2937);

  // Background colors (Dark mode)
  static const Color backgroundColorDark = Color(0xFF0F1419); // Preto azulado
  static const Color surfaceColorDark = Color(0xFF1A1F2E); // Cinza escuro azulado
  static const Color onBackgroundDark = Color(0xFFF9FAFB); // Off-white
  static const Color onSurfaceDark = Color(0xFFF9FAFB);

  // Error colors (Vermelho moderno)
  static const Color errorColor = Color(0xFFEF4444); // Red-500
  static const Color errorLight = Color(0xFFFEF2F2); // Red-50
  static const Color errorDark = Color(0xFF7F1D1D); // Red-900
  static const Color onError = Colors.white;

  // Neutral colors (Tailwind Gray scale)
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Semantic colors (Modernas e vibrantes)
  static const Color successColor = Color(0xFF10B981); // Green-500
  static const Color successLight = Color(0xFFF0FDF4); // Green-50
  static const Color successDark = Color(0xFF065F46); // Green-900

  static const Color warningColor = Color(0xFFF59E0B); // Amber-500
  static const Color warningLight = Color(0xFFFFFBEB); // Amber-50
  static const Color warningDark = Color(0xFF78350F); // Amber-900

  static const Color infoColor = Color(0xFF3B82F6); // Blue-500
  static const Color infoLight = Color(0xFFEFF6FF); // Blue-50
  static const Color infoDark = Color(0xFF1E3A8A); // Blue-900

  // Entity colors (Paleta coordenada)
  static const Color itemsColor = Color(0xFF6366F1); // Indigo
  static const Color productsColor = Color(0xFF10B981); // Green
  static const Color ordersColor = Color(0xFFF59E0B); // Amber
  static const Color customersColor = Color(0xFFA855F7); // Purple-500

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
  // LIGHT THEME (Tema Claro - Modernizado)
  // ========================================

  static ThemeData get lightTheme {
    return ThemeData(
      // Material 3
      useMaterial3: true,

      // Brilho
      brightness: Brightness.light,

      // Esquema de cores
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        primaryContainer: primaryLight,
        secondary: secondaryColor,
        secondaryContainer: secondaryLight,
        tertiary: customersColor,
        surface: surfaceColor,
        surfaceVariant: grey100,
        background: backgroundColor,
        error: errorColor,
        errorContainer: errorLight,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onBackground: onBackground,
        onError: onError,
        outline: grey300,
        shadow: grey900,
      ),

      // Cores primárias (legado)
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      // AppBar moderna (flat)
      appBarTheme: const AppBarTheme(
        elevation: elevationNone, // Flat design
        centerTitle: false,
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        foregroundColor: onSurface,
        iconTheme: IconThemeData(color: onSurface),
        titleTextStyle: TextStyle(
          color: onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
      ),

      // Cards modernos (flat com borda)
      cardTheme: CardThemeData(
        elevation: elevationNone, // Flat design
        color: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          side: const BorderSide(color: grey200, width: 1),
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
          elevation: elevationNone,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
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
            borderRadius: BorderRadius.circular(radiusLarge),
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
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
          side: const BorderSide(color: grey300),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Campos de texto modernos
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: grey50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: paddingMedium,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
      ),

      // FloatingActionButton moderno
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        elevation: elevationNone,
        focusElevation: elevationLow,
        hoverElevation: elevationLow,
        highlightElevation: elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: grey100,
        selectedColor: primaryLight,
        secondarySelectedColor: secondaryLight,
        padding: const EdgeInsets.symmetric(
          horizontal: paddingSmall,
          vertical: space4,
        ),
        labelStyle: const TextStyle(fontSize: 14),
        secondaryLabelStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          side: const BorderSide(color: grey200),
        ),
        side: const BorderSide(color: grey200),
      ),

      // Dialogs
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusExtraLarge),
        ),
        elevation: elevationHigh,
      ),

      // BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusExtraLarge),
          ),
        ),
        elevation: elevationHigh,
      ),

      // Divisor
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
        color: grey200,
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
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: onSurface,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: onSurface,
          letterSpacing: -1.0,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: onSurface,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: onSurface,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: onSurface,
          letterSpacing: -0.25,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: onSurface,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: onSurface,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: onSurface,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurface,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: onSurface,
          letterSpacing: 0.15,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: onSurface,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: grey600,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurface,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onSurface,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: grey600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ========================================
  // DARK THEME (Tema Escuro - Modernizado)
  // ========================================

  static ThemeData get darkTheme {
    return ThemeData(
      // Material 3
      useMaterial3: true,

      // Brilho
      brightness: Brightness.dark,

      // Esquema de cores
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        primaryContainer: primaryDark,
        secondary: secondaryColor,
        secondaryContainer: secondaryDark,
        tertiary: customersColor,
        surface: surfaceColorDark,
        surfaceVariant: grey800,
        background: backgroundColorDark,
        error: errorColor,
        errorContainer: errorDark,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurfaceDark,
        onBackground: onBackgroundDark,
        onError: onError,
        outline: grey700,
        shadow: Colors.black,
      ),

      // Cores primárias (legado)
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColorDark,

      // AppBar dark (flat)
      appBarTheme: const AppBarTheme(
        elevation: elevationNone,
        centerTitle: false,
        backgroundColor: surfaceColorDark,
        surfaceTintColor: Colors.transparent,
        foregroundColor: onSurfaceDark,
        iconTheme: IconThemeData(color: onSurfaceDark),
        titleTextStyle: TextStyle(
          color: onSurfaceDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
      ),

      // Cards dark (flat com borda)
      cardTheme: CardThemeData(
        elevation: elevationNone,
        color: surfaceColorDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          side: const BorderSide(color: grey800, width: 1),
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
          elevation: elevationNone,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
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
            borderRadius: BorderRadius.circular(radiusLarge),
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
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
          side: const BorderSide(color: grey700),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),

      // Campos de texto dark
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: grey800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: paddingMedium,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: grey700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: grey700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
      ),

      // FloatingActionButton dark
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        elevation: elevationNone,
        focusElevation: elevationLow,
        hoverElevation: elevationLow,
        highlightElevation: elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
      ),

      // Chips dark
      chipTheme: ChipThemeData(
        backgroundColor: grey800,
        selectedColor: primaryDark,
        secondarySelectedColor: secondaryDark,
        padding: const EdgeInsets.symmetric(
          horizontal: paddingSmall,
          vertical: space4,
        ),
        labelStyle: const TextStyle(fontSize: 14, color: onSurfaceDark),
        secondaryLabelStyle: const TextStyle(fontSize: 14, color: onSurfaceDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          side: const BorderSide(color: grey700),
        ),
        side: const BorderSide(color: grey700),
      ),

      // Dialogs dark
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColorDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusExtraLarge),
        ),
        elevation: elevationHigh,
      ),

      // BottomSheet dark
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColorDark,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusExtraLarge),
          ),
        ),
        elevation: elevationHigh,
      ),

      // Divisor dark
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
        color: grey800,
      ),

      // ListTile dark
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: paddingMedium,
          vertical: space8,
        ),
      ),

      // IconTheme dark
      iconTheme: const IconThemeData(
        size: iconSizeMedium,
        color: onSurfaceDark,
      ),

      // Tipografia dark
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: onSurfaceDark,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: onSurfaceDark,
          letterSpacing: -1.0,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: onSurfaceDark,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: onSurfaceDark,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: onSurfaceDark,
          letterSpacing: -0.25,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: onSurfaceDark,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: onSurfaceDark,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: onSurfaceDark,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurfaceDark,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: onSurfaceDark,
          letterSpacing: 0.15,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: onSurfaceDark,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: grey400,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurfaceDark,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onSurfaceDark,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: grey400,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}