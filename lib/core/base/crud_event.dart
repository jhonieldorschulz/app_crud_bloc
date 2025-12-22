import 'package:equatable/equatable.dart';

/// CrudEvent<T> - Eventos genéricos para operações CRUD
///
/// T: Tipo da entidade
///
/// Sealed class garante pattern matching exhaustivo
sealed class CrudEvent<T> extends Equatable {
  const CrudEvent();
}

/// LoadAllEvent - Carregar todas as entidades
///
/// Uso:
/// ```dart
/// itemBloc.add(const LoadAllEvent<Item>());
/// productBloc.add(const LoadAllEvent<Product>());
/// ```
final class LoadAllEvent<T> extends CrudEvent<T> {
  const LoadAllEvent();

  @override
  List<Object?> get props => [];
}

/// LoadByIdEvent - Carregar entidade específica por ID
///
/// Uso:
/// ```dart
/// itemBloc.add(LoadByIdEvent<Item>(id: 1));
/// ```
final class LoadByIdEvent<T> extends CrudEvent<T> {
  final Object id;

  const LoadByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

/// CreateEvent - Criar nova entidade
///
/// Usa Map para dados flexíveis antes da validação
///
/// Uso:
/// ```dart
/// itemBloc.add(CreateEvent<Item>(data: {
///   'title': 'Novo Item',
///   'description': 'Descrição aqui',
/// }));
/// ```
final class CreateEvent<T> extends CrudEvent<T> {
  final Map<String, dynamic> data;

  const CreateEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

/// UpdateEvent - Atualizar entidade existente
///
/// Recebe entidade completa (já tipada)
///
/// Uso:
/// ```dart
/// final updatedItem = item.copyWith(title: 'Novo Título');
/// itemBloc.add(UpdateEvent<Item>(entity: updatedItem));
/// ```
final class UpdateEvent<T> extends CrudEvent<T> {
  final T entity;

  const UpdateEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
}

/// DeleteEvent - Deletar entidade por ID
///
/// Uso:
/// ```dart
/// itemBloc.add(DeleteEvent<Item>(id: 1));
/// ```
final class DeleteEvent<T> extends CrudEvent<T> {
  final Object id;

  const DeleteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

/// DeleteAllEvent - Deletar todas as entidades
///
/// Uso comum: limpar dados em massa, reset
///
/// Uso:
/// ```dart
/// itemBloc.add(const DeleteAllEvent<Item>());
/// ```
final class DeleteAllEvent<T> extends CrudEvent<T> {
  const DeleteAllEvent();

  @override
  List<Object?> get props => [];
}