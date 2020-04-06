import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_data/data_objects.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';

/// Maps [TEntity] from [TSource].
abstract class EntityMapper<TEntity extends EntityBase, TSource extends Object> {
  /// Create an instance of [TEntity] from a [TSource];
  TEntity toEntity(TSource source);
}

/// Maps [TDataObject] from [TSource].
abstract class DataObjectMapper<TDataObject extends DataClass, TSource extends Object> {
  /// Create an instance of [TDataObject] from a [TSource];
  TDataObject toDataObject(TSource source);
}

/// Maps [TDataContract] from [TSource].
abstract class DataContractMapper<TDataContract extends DataContractBase, TSource extends Object> {
  /// Create an instance of [TDataContract] from a [TSource];
  TDataContract toDataContract(TSource source);
}

/// Maps [TEntity] from [TDataObject], and vice-versa.
abstract class EntityDataObjectMapper<TEntity extends EntityBase, TDataObject extends DataClass>
    implements EntityMapper<TEntity, TDataObject>, DataObjectMapper<TDataObject, TEntity> {}

/// Maps [TEntity] from [TDataContract], and vice-versa.
abstract class EntityDataContractMapper<TEntity extends EntityBase, TDataContract extends DataContractBase>
    implements EntityMapper<TEntity, TDataContract>, DataContractMapper<TDataContract, TEntity> {}

/// Maps [TEntity] from [TDataContract] or [TDataObject], and vice-versa.
abstract class EntityDataContractObjectMapper<TEntity extends EntityBase, TDataContract extends DataContractBase,
        TDataObject extends DataClass>
    implements DataObjectMapper<TDataObject, TEntity>, DataContractMapper<TDataContract, TEntity> {
  /// Create an instance of [TEntity] from a [TDataContract];
  TEntity toEntityFromDataContract(TDataContract source);

  /// Create an instance of [TEntity] from a [TDataObject];
  TEntity toEntityFromDataObject(TDataObject source);
}
