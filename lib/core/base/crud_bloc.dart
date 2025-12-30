import 'package:flutter_bloc/flutter_bloc.dart';
import 'crud_event.dart';
import 'crud_state.dart';
import 'base_repository.dart';

/// CrudBloc<T> - BLoC genérico para operações CRUD
///
/// T: Tipo da entidade (deve extender BaseEntity)
///
/// ESTE É O CORAÇÃO DA ARQUITETURA GENÉRICA!
///
/// Princípios SOLID aplicados:
/// - Single Responsibility: Apenas lógica CRUD
/// - Open/Closed: Genérico (aberto), não muda (fechado)
/// - Liskov Substitution: Funciona com qualquer BaseEntity
/// - Dependency Inversion: Depende de BaseRepository (abstração)
///
/// Uso:
/// ```dart
/// // Para Item:
/// final itemBloc = CrudBloc<Item>(
///   repository: ItemRepository(database: database),
/// );
///
/// // Para Product:
/// final productBloc = CrudBloc<Product>(
///   repository: ProductRepository(database: database),
/// );
///
/// // Mesma lógica, tipos diferentes!
/// ```
class CrudBloc<T> extends Bloc<CrudEvent<T>, CrudState<T>> {
  final BaseRepository<T> repository;

  CrudBloc({required this.repository}) : super(const CrudInitial()) {
    // Pattern matching com sealed classes
    on<CrudEvent<T>>((event, emit) async {
      switch (event) {
        case LoadAllEvent():
          await _onLoadAll(emit);
        case LoadByIdEvent():
          await _onLoadById(event, emit);
        case CreateEvent():
          await _onCreate(event, emit);
        case UpdateEvent():
          await _onUpdate(event, emit);
        case DeleteEvent():
          await _onDelete(event, emit);
        case DeleteAllEvent():
          await _onDeleteAll(emit);
      }
    });
  }

  /// Carregar todas as entidades
  Future<void> _onLoadAll(Emitter<CrudState<T>> emit) async {
    emit(const CrudLoading());

    try {
      final entities = await repository.getAll();
      emit(CrudLoaded(entities: entities));
    } catch (e) {
      emit(CrudError(message: 'Failed to load: $e'));
    }
  }

  /// Carregar entidade por ID
  Future<void> _onLoadById(
      LoadByIdEvent<T> event,
      Emitter<CrudState<T>> emit,
      ) async {
    emit(const CrudLoading());

    try {
      final entity = await repository.getById(event.id);

      if (entity == null) {
        emit(const CrudError(message: 'Entity not found'));
        return;
      }

      emit(CrudDetailLoaded(entity: entity));
    } catch (e) {
      emit(CrudError(message: 'Failed to load detail: $e'));
    }
  }

  /// Criar nova entidade
  Future<void> _onCreate(
      CreateEvent<T> event,
      Emitter<CrudState<T>> emit,
      ) async {
    emit(const CrudLoading());

    try {
      await repository.create(event.data);
      emit(const CrudOperationSuccess(message: 'Created successfully'));

      // Recarregar lista automaticamente
      add(const LoadAllEvent());
    } catch (e) {
      print(e.toString());
      emit(CrudError(message: 'Failed to create: $e'));
    }
  }

  /// Atualizar entidade
  Future<void> _onUpdate(
      UpdateEvent<T> event,
      Emitter<CrudState<T>> emit,
      ) async {
    emit(const CrudLoading());

    try {
      final success = await repository.update(event.entity);

      if (!success) {
        emit(const CrudError(message: 'Entity not found'));
        return;
      }

      emit(const CrudOperationSuccess(message: 'Updated successfully'));

      // Recarregar lista automaticamente
      add(const LoadAllEvent());
    } catch (e) {
      emit(CrudError(message: 'Failed to update: $e'));
    }
  }

  /// Deletar entidade
  Future<void> _onDelete(
      DeleteEvent<T> event,
      Emitter<CrudState<T>> emit,
      ) async {
    emit(const CrudLoading());

    try {
      final success = await repository.delete(event.id);

      if (!success) {
        emit(const CrudError(message: 'Entity not found'));
        return;
      }

      emit(const CrudOperationSuccess(message: 'Deleted successfully'));

      // Recarregar lista automaticamente
      add(const LoadAllEvent());
    } catch (e) {
      emit(CrudError(message: 'Failed to delete: $e'));
    }
  }

  /// Deletar todas as entidades
  Future<void> _onDeleteAll(Emitter<CrudState<T>> emit) async {
    emit(const CrudLoading());

    try {
      await repository.deleteAll();
      emit(const CrudOperationSuccess(message: 'All deleted'));

      // Recarregar lista (vazia)
      add(const LoadAllEvent());
    } catch (e) {
      emit(CrudError(message: 'Failed to delete all: $e'));
    }
  }
}