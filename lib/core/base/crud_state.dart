import 'package:equatable/equatable.dart';

/// CrudState<T> - Estados genéricos para operações CRUD
/// 
/// T: Tipo da entidade
/// 
/// Sealed class garante pattern matching exhaustivo
sealed class CrudState<T> extends Equatable {
  const CrudState();
}

/// CrudInitial - Estado inicial (antes de qualquer operação)
final class CrudInitial<T> extends CrudState<T> {
  const CrudInitial();

  @override
  List<Object?> get props => [];
}

/// CrudLoading - Operação em andamento
/// 
/// Exibir: CircularProgressIndicator, Skeleton, Shimmer
final class CrudLoading<T> extends CrudState<T> {
  const CrudLoading();

  @override
  List<Object?> get props => [];
}

/// CrudLoaded - Lista de entidades carregada com sucesso
/// 
/// Usado para telas de lista (ItemListScreen, ProductListScreen)
final class CrudLoaded<T> extends CrudState<T> {
  final List<T> entities;

  const CrudLoaded({required this.entities});

  /// Helpers úteis
  bool get isEmpty => entities.isEmpty;
  bool get isNotEmpty => entities.isNotEmpty;
  int get count => entities.length;

  @override
  List<Object?> get props => [entities];
}

/// CrudDetailLoaded - Entidade única carregada com sucesso
/// 
/// Usado para telas de detalhe (ItemDetailScreen, ProductDetailScreen)
final class CrudDetailLoaded<T> extends CrudState<T> {
  final T entity;

  const CrudDetailLoaded({required this.entity});

  @override
  List<Object?> get props => [entity];
}

/// CrudOperationSuccess - Operação (create/update/delete) bem-sucedida
/// 
/// Usado para feedback ao usuário (SnackBar)
/// Após emitir, geralmente dispara LoadAllEvent para atualizar lista
final class CrudOperationSuccess<T> extends CrudState<T> {
  final String message;

  const CrudOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// CrudError - Erro em qualquer operação
/// 
/// Usado para exibir erro ao usuário
final class CrudError<T> extends CrudState<T> {
  final String message;

  const CrudError({required this.message});

  @override
  List<Object?> get props => [message];
}