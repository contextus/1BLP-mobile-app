import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_data/data_objects.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';

abstract class EntityMapper<TEntity extends EntityBase, TSource extends Object> {
  TEntity toEntity(TSource source);
}

abstract class DataObjectMapper<TDataObject extends DataClass, TSource extends Object> {
  TDataObject toDataObject(TSource source);
}

abstract class DataContractMapper<TDataContract extends DataContractBase, TSource extends Object> {
  TDataContract toDataContract(TSource source);
}

abstract class EntityDataObjectMapper<TEntity extends EntityBase, TDataObject extends DataClass>
    implements EntityMapper<TEntity, TDataObject>, DataObjectMapper<TDataObject, TEntity> {}

abstract class EntityDataContractMapper<TEntity extends EntityBase, TDataContract extends DataContractBase>
    implements EntityMapper<TEntity, TDataContract>, DataContractMapper<TDataContract, TEntity> {}

abstract class EntityDataContractObjectMapper<TEntity extends EntityBase, TDataContract extends DataContractBase,
        TDataObject extends DataClass>
    implements DataObjectMapper<TDataObject, TEntity>, DataContractMapper<TDataContract, TEntity> {
  TEntity toEntityFromDataContract(TDataContract source);

  TEntity toEntityFromDataObject(TDataObject source);
}
