import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/item_repository.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository _repository;

  ItemBloc({required ItemRepository repository})
      : _repository = repository,
        super(const ItemInitial()) {
    on<ItemEvent>((event, emit) async {
      await switch (event) {
        LoadItemsEvent() => _onLoadItems(emit),
        LoadItemDetailEvent() => _onLoadDetail(event, emit),
        AddItemEvent() => _onAdd(event, emit),
        UpdateItemEvent() => _onUpdate(event, emit),
        DeleteItemEvent() => _onDelete(event, emit),
        DeleteAllItemsEvent() => _onDeleteAll(emit),
      };
    });
  }

  Future<void> _onLoadItems(Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    try {
      final items = await _repository.getAllItems();
      emit(ItemsLoaded(items: items));
    } catch (e) {
      emit(ItemError(message: 'Error: $e'));
    }
  }

  Future<void> _onLoadDetail(LoadItemDetailEvent event, Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    try {
      final item = await _repository.getItemById(event.id);
      if (item != null) {
        emit(ItemDetailLoaded(item: item));
      } else {
        emit(const ItemError(message: 'Item not found'));
      }
    } catch (e) {
      emit(ItemError(message: 'Error: $e'));
    }
  }

  Future<void> _onAdd(AddItemEvent event, Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    try {
      await _repository.createItem(title: event.title, description: event.description);
      emit(const ItemOperationSuccess(message: 'Item added!'));
      add(const LoadItemsEvent());
    } catch (e) {
      emit(ItemError(message: 'Error: $e'));
    }
  }

  Future<void> _onUpdate(UpdateItemEvent event, Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    try {
      await _repository.updateItem(event.item);
      emit(const ItemOperationSuccess(message: 'Item updated!'));
      add(const LoadItemsEvent());
    } catch (e) {
      emit(ItemError(message: 'Error: $e'));
    }
  }

  Future<void> _onDelete(DeleteItemEvent event, Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    try {
      await _repository.deleteItem(event.id);
      emit(const ItemOperationSuccess(message: 'Item deleted!'));
      add(const LoadItemsEvent());
    } catch (e) {
      emit(ItemError(message: 'Error: $e'));
    }
  }

  Future<void> _onDeleteAll(Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    try {
      await _repository.deleteAllItems();
      emit(const ItemOperationSuccess(message: 'All deleted!'));
      add(const LoadItemsEvent());
    } catch (e) {
      emit(ItemError(message: 'Error: $e'));
    }
  }
}