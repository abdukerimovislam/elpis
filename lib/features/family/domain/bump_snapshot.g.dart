// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bump_snapshot.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBumpSnapshotCollection on Isar {
  IsarCollection<BumpSnapshot> get bumpSnapshots => this.collection();
}

const BumpSnapshotSchema = CollectionSchema(
  name: r'BumpSnapshot',
  id: 629651519232134318,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'fileName': PropertySchema(
      id: 1,
      name: r'fileName',
      type: IsarType.string,
    ),
    r'week': PropertySchema(
      id: 2,
      name: r'week',
      type: IsarType.long,
    )
  },
  estimateSize: _bumpSnapshotEstimateSize,
  serialize: _bumpSnapshotSerialize,
  deserialize: _bumpSnapshotDeserialize,
  deserializeProp: _bumpSnapshotDeserializeProp,
  idName: r'id',
  indexes: {
    r'week': IndexSchema(
      id: -4686994473724219516,
      name: r'week',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'week',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _bumpSnapshotGetId,
  getLinks: _bumpSnapshotGetLinks,
  attach: _bumpSnapshotAttach,
  version: '3.1.0+1',
);

int _bumpSnapshotEstimateSize(
  BumpSnapshot object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fileName.length * 3;
  return bytesCount;
}

void _bumpSnapshotSerialize(
  BumpSnapshot object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeString(offsets[1], object.fileName);
  writer.writeLong(offsets[2], object.week);
}

BumpSnapshot _bumpSnapshotDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BumpSnapshot(
    date: reader.readDateTime(offsets[0]),
    fileName: reader.readString(offsets[1]),
    id: id,
    week: reader.readLong(offsets[2]),
  );
  return object;
}

P _bumpSnapshotDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bumpSnapshotGetId(BumpSnapshot object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bumpSnapshotGetLinks(BumpSnapshot object) {
  return [];
}

void _bumpSnapshotAttach(
    IsarCollection<dynamic> col, Id id, BumpSnapshot object) {
  object.id = id;
}

extension BumpSnapshotByIndex on IsarCollection<BumpSnapshot> {
  Future<BumpSnapshot?> getByWeek(int week) {
    return getByIndex(r'week', [week]);
  }

  BumpSnapshot? getByWeekSync(int week) {
    return getByIndexSync(r'week', [week]);
  }

  Future<bool> deleteByWeek(int week) {
    return deleteByIndex(r'week', [week]);
  }

  bool deleteByWeekSync(int week) {
    return deleteByIndexSync(r'week', [week]);
  }

  Future<List<BumpSnapshot?>> getAllByWeek(List<int> weekValues) {
    final values = weekValues.map((e) => [e]).toList();
    return getAllByIndex(r'week', values);
  }

  List<BumpSnapshot?> getAllByWeekSync(List<int> weekValues) {
    final values = weekValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'week', values);
  }

  Future<int> deleteAllByWeek(List<int> weekValues) {
    final values = weekValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'week', values);
  }

  int deleteAllByWeekSync(List<int> weekValues) {
    final values = weekValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'week', values);
  }

  Future<Id> putByWeek(BumpSnapshot object) {
    return putByIndex(r'week', object);
  }

  Id putByWeekSync(BumpSnapshot object, {bool saveLinks = true}) {
    return putByIndexSync(r'week', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWeek(List<BumpSnapshot> objects) {
    return putAllByIndex(r'week', objects);
  }

  List<Id> putAllByWeekSync(List<BumpSnapshot> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'week', objects, saveLinks: saveLinks);
  }
}

extension BumpSnapshotQueryWhereSort
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QWhere> {
  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhere> anyWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'week'),
      );
    });
  }
}

extension BumpSnapshotQueryWhere
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QWhereClause> {
  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> weekEqualTo(
      int week) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'week',
        value: [week],
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> weekNotEqualTo(
      int week) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'week',
              lower: [],
              upper: [week],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'week',
              lower: [week],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'week',
              lower: [week],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'week',
              lower: [],
              upper: [week],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> weekGreaterThan(
    int week, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'week',
        lower: [week],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> weekLessThan(
    int week, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'week',
        lower: [],
        upper: [week],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterWhereClause> weekBetween(
    int lowerWeek,
    int upperWeek, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'week',
        lower: [lowerWeek],
        includeLower: includeLower,
        upper: [upperWeek],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BumpSnapshotQueryFilter
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QFilterCondition> {
  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> weekEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'week',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition>
      weekGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'week',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> weekLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'week',
        value: value,
      ));
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterFilterCondition> weekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'week',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BumpSnapshotQueryObject
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QFilterCondition> {}

extension BumpSnapshotQueryLinks
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QFilterCondition> {}

extension BumpSnapshotQuerySortBy
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QSortBy> {
  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> sortByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> sortByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> sortByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> sortByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }
}

extension BumpSnapshotQuerySortThenBy
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QSortThenBy> {
  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QAfterSortBy> thenByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }
}

extension BumpSnapshotQueryWhereDistinct
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QDistinct> {
  QueryBuilder<BumpSnapshot, BumpSnapshot, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QDistinct> distinctByFileName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BumpSnapshot, BumpSnapshot, QDistinct> distinctByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'week');
    });
  }
}

extension BumpSnapshotQueryProperty
    on QueryBuilder<BumpSnapshot, BumpSnapshot, QQueryProperty> {
  QueryBuilder<BumpSnapshot, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BumpSnapshot, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<BumpSnapshot, String, QQueryOperations> fileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileName');
    });
  }

  QueryBuilder<BumpSnapshot, int, QQueryOperations> weekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'week');
    });
  }
}
