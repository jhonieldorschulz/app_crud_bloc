import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Item Manager'**
  String get appTitle;

  /// Home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Items menu
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// Item list screen title
  ///
  /// In en, this message translates to:
  /// **'Item List'**
  String get itemList;

  /// Item details screen title
  ///
  /// In en, this message translates to:
  /// **'Item Details'**
  String get itemDetails;

  /// Add item screen title
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// Edit item screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get editItem;

  /// New item label
  ///
  /// In en, this message translates to:
  /// **'New Item'**
  String get newItem;

  /// Title field label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Created date label
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get createdAt;

  /// Search hint text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Save changes button
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Delete all button
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// Edit button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// View button
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// Message when list is empty
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first item'**
  String get tapToAddFirst;

  /// Retry message
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retry;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading items...'**
  String get loadingItems;

  /// Delete confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirmDelete;

  /// Delete confirmation message
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this item?'**
  String get confirmDeleteMessage;

  /// Delete all confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm Mass Deletion'**
  String get confirmDeleteAllTitle;

  /// Delete all confirmation message
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete ALL items?'**
  String get confirmDeleteAllMessage;

  /// Title required validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get validationTitleRequired;

  /// Title min length validation error
  ///
  /// In en, this message translates to:
  /// **'Title must be at least 3 characters'**
  String get validationTitleMinLength;

  /// Description required validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get validationDescriptionRequired;

  /// Description min length validation error
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 10 characters'**
  String get validationDescriptionMinLength;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language selection label
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// About section label
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Developer label
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// Theme setting label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Appearance section title
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Products menu
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Product singular
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// Product list screen title
  ///
  /// In en, this message translates to:
  /// **'Product List'**
  String get productList;

  /// Product details screen title
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// Create product button
  ///
  /// In en, this message translates to:
  /// **'Create Product'**
  String get createProduct;

  /// Edit product screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// Delete product button
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// Product created success message
  ///
  /// In en, this message translates to:
  /// **'Product created successfully'**
  String get productCreated;

  /// Product updated success message
  ///
  /// In en, this message translates to:
  /// **'Product updated successfully'**
  String get productUpdated;

  /// Product deleted success message
  ///
  /// In en, this message translates to:
  /// **'Product deleted successfully'**
  String get productDeleted;

  /// Delete product confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this product?'**
  String get deleteProductConfirmation;

  /// Empty products list message
  ///
  /// In en, this message translates to:
  /// **'No products'**
  String get noProducts;

  /// Empty products list call to action
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to create your first product'**
  String get createFirstProduct;

  /// Product not found error
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// Search products hint
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProducts;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Price field label
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// Unit price label
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPrice;

  /// Stock field label
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// Category field label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Barcode field label
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode;

  /// Product status label
  ///
  /// In en, this message translates to:
  /// **'Product Status'**
  String get productStatus;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Inactive status
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Product active switch label
  ///
  /// In en, this message translates to:
  /// **'Product Active'**
  String get productActive;

  /// Product active description
  ///
  /// In en, this message translates to:
  /// **'Product available for sale'**
  String get productActiveDescription;

  /// Product inactive description
  ///
  /// In en, this message translates to:
  /// **'Product unavailable for sale'**
  String get productInactiveDescription;

  /// Product name field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: Dell Inspiron 15 Notebook'**
  String get productNameHint;

  /// Product description field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: Intel Core i7, 16GB RAM, 512GB SSD'**
  String get productDescriptionHint;

  /// Category field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: Electronics'**
  String get categoryHint;

  /// Price field helper text
  ///
  /// In en, this message translates to:
  /// **'Enter price in reais (Ex: 19.99)'**
  String get priceHelper;

  /// Name required validation
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// Name min length validation
  ///
  /// In en, this message translates to:
  /// **'Name must have at least 3 characters'**
  String get nameMinLength;

  /// Description required validation
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get descriptionRequired;

  /// Description min length validation
  ///
  /// In en, this message translates to:
  /// **'Description must have at least 10 characters'**
  String get descriptionMinLength;

  /// Price required validation
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get priceRequired;

  /// Price invalid validation
  ///
  /// In en, this message translates to:
  /// **'Enter a valid price greater than 0'**
  String get priceInvalid;

  /// Stock required validation
  ///
  /// In en, this message translates to:
  /// **'Stock is required'**
  String get stockRequired;

  /// Stock invalid validation
  ///
  /// In en, this message translates to:
  /// **'Enter a valid stock (0 or more)'**
  String get stockInvalid;

  /// Category required validation
  ///
  /// In en, this message translates to:
  /// **'Category is required'**
  String get categoryRequired;

  /// Category min length validation
  ///
  /// In en, this message translates to:
  /// **'Category must have at least 3 characters'**
  String get categoryMinLength;

  /// Out of stock status
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// Low stock status
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get lowStock;

  /// Available status
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// Restocking recommendation message
  ///
  /// In en, this message translates to:
  /// **'Restocking recommended'**
  String get restockingRecommended;

  /// General information section title
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInfo;

  /// Stock and price section title
  ///
  /// In en, this message translates to:
  /// **'Stock and Price'**
  String get stockAndPrice;

  /// Additional information section title
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInfo;

  /// Units label
  ///
  /// In en, this message translates to:
  /// **'units'**
  String get units;

  /// Total stock value label
  ///
  /// In en, this message translates to:
  /// **'Total Stock Value'**
  String get totalStockValue;

  /// Updated date label
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get updatedAt;

  /// Optional field indicator
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get optional;

  /// Create button
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Update button
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Delete all products confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all products? This action cannot be undone.'**
  String get deleteAllConfirmation;

  /// No search results message
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// Search for label
  ///
  /// In en, this message translates to:
  /// **'Search for'**
  String get searchFor;

  /// Error label
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
