// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Item Manager';

  @override
  String get itemList => 'Item List';

  @override
  String get itemDetails => 'Item Details';

  @override
  String get addItem => 'Add Item';

  @override
  String get editItem => 'Edit Item';

  @override
  String get newItem => 'New Item';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get createdAt => 'Created at';

  @override
  String get save => 'Save';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get edit => 'Edit';

  @override
  String get view => 'View';

  @override
  String get back => 'Back';

  @override
  String get confirmDelete => 'Confirm Deletion';

  @override
  String get confirmDeleteMessage => 'Do you really want to delete this item?';

  @override
  String get confirmDeleteAllTitle => 'Confirm Mass Deletion';

  @override
  String get confirmDeleteAllMessage =>
      'Do you really want to delete ALL items?';

  @override
  String get noItemsFound => 'No items found';

  @override
  String get tapToAddFirst => 'Tap + to add your first item';

  @override
  String get retry => 'Try Again';

  @override
  String get validationTitleRequired => 'Please enter a title';

  @override
  String get validationTitleMinLength => 'Title must be at least 3 characters';

  @override
  String get validationDescriptionRequired => 'Please enter a description';

  @override
  String get validationDescriptionMinLength =>
      'Description must be at least 10 characters';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get developer => 'Developer';

  @override
  String get theme => 'Theme';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get appearance => 'Appearance';

  @override
  String get loadingItems => 'Loading items...';
}
