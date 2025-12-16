import 'package:equatable/equatable.dart';
import '../../data/database/app_database.dart';

sealed class ItemState extends Equatable {
  const ItemState();
}

final class ItemInitial extends ItemState {
  const ItemInitial();
  @override
  List<Object?> get props => [];
}

final class ItemLoading extends ItemState {
  const ItemLoading();
  @override
  List<Object?> get props => [];
}

final class ItemsLoaded extends ItemState {
  final List<Item> items;
  const ItemsLoaded({required this.items});
  @override
  List<Object?> get props => [items];
}

final class ItemDetailLoaded extends ItemState {
  final Item item;
  const ItemDetailLoaded({required this.item});
  @override
  List<Object?> get props => [item];
}

final class ItemOperationSuccess extends ItemState {
  final String message;
  const ItemOperationSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

final class ItemError extends ItemState {
  final String message;
  const ItemError({required this.message});
  @override
  List<Object?> get props => [message];
}