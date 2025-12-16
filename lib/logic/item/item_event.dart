import 'package:equatable/equatable.dart';
import '../../data/database/app_database.dart';

sealed class ItemEvent extends Equatable {
  const ItemEvent();
}

final class LoadItemsEvent extends ItemEvent {
  const LoadItemsEvent();
  @override
  List<Object?> get props => [];
}

final class LoadItemDetailEvent extends ItemEvent {
  final int id;
  const LoadItemDetailEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

final class AddItemEvent extends ItemEvent {
  final String title;
  final String description;
  const AddItemEvent({required this.title, required this.description});
  @override
  List<Object?> get props => [title, description];
}

final class UpdateItemEvent extends ItemEvent {
  final Item item;
  const UpdateItemEvent({required this.item});
  @override
  List<Object?> get props => [item];
}

final class DeleteItemEvent extends ItemEvent {
  final int id;
  const DeleteItemEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

final class DeleteAllItemsEvent extends ItemEvent {
  const DeleteAllItemsEvent();
  @override
  List<Object?> get props => [];
}