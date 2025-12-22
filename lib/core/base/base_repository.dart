
/// BaseRepository<T> - Interface genérica para repositórios
///
/// T: Tipo da entidade (deve extender BaseEntity)
///
/// Princípios SOLID aplicados:
/// - Single Responsibility: Apenas operações de dados
/// - Open/Closed: Aberto para extensão (generics), fechado para modificação
/// - Liskov Substitution: Qualquer implementação pode substituir
///
/// Exemplo de uso:
/// ```dart
/// class ItemRepository implements BaseRepository<Item> {
///   final AppDatabase database;
///   ItemRepository({required this.database});
///
///   @override
///   Future<List<Item>> getAll() => database.itemsDao.getAllItems();
///   // ... outros métodos
/// }
/// ```
abstract class BaseRepository<T> {
  /// Buscar todas as entidades
  /// Retorna lista vazia se não houver dados
  Future<List<T>> getAll();

  /// Buscar entidade por ID
  /// Retorna null se não encontrado
  Future<T?> getById(Object id);

  /// Criar nova entidade
  /// Retorna o ID da entidade criada
  /// Pode lançar exceção se validação falhar
  Future<Object> create(Map<String, dynamic> data);

  /// Atualizar entidade existente
  /// Retorna true se atualizado com sucesso
  /// Retorna false se entidade não existe
  Future<bool> update(T entity);

  /// Deletar entidade por ID
  /// Retorna true se deletado com sucesso
  /// Retorna false se entidade não existe
  Future<bool> delete(Object id);

  /// Deletar todas as entidades
  /// Útil para reset ou limpeza
  Future<void> deleteAll();

  /// Buscar entidades por query de texto
  /// Implementação específica de cada entidade
  /// Exemplo: buscar por título, descrição, categoria, etc
  Future<List<T>> search(String query);
}