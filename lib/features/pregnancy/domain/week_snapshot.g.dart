// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_snapshot.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeekSnapshotCollection on Isar {
  IsarCollection<WeekSnapshot> get weekSnapshots => this.collection();
}

const WeekSnapshotSchema = CollectionSchema(
  name: r'WeekSnapshot',
  id: 3992717180944552424,
  properties: {
    r'bellyGirthCm': PropertySchema(
      id: 0,
      name: r'bellyGirthCm',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'letterToBaby': PropertySchema(
      id: 2,
      name: r'letterToBaby',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 3,
      name: r'notes',
      type: IsarType.string,
    ),
    r'photoPaths': PropertySchema(
      id: 4,
      name: r'photoPaths',
      type: IsarType.stringList,
    ),
    r'week': PropertySchema(
      id: 5,
      name: r'week',
      type: IsarType.long,
    ),
    r'weightKg': PropertySchema(
      id: 6,
      name: r'weightKg',
      type: IsarType.double,
    )
  },
  estimateSize: _weekSnapshotEstimateSize,
  serialize: _weekSnapshotSerialize,
  deserialize: _weekSnapshotDeserialize,
  deserializeProp: _weekSnapshotDeserializeProp,
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
  getId: _weekSnapshotGetId,
  getLinks: _weekSnapshotGetLinks,
  attach: _weekSnapshotAttach,
  version: '3.1.0+1',
);

int _weekSnapshotEstimateSize(
  WeekSnapshot object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.letterToBaby;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.photoPaths;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  return bytesCount;
}

void _weekSnapshotSerialize(
  WeekSnapshot object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bellyGirthCm);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.letterToBaby);
  writer.writeString(offsets[3], object.notes);
  writer.writeStringList(offsets[4], object.photoPaths);
  writer.writeLong(offsets[5], object.week);
  writer.writeDouble(offsets[6], object.weightKg);
}

WeekSnapshot _weekSnapshotDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeekSnapshot(
    bellyGirthCm: reader.readDoubleOrNull(offsets[0]),
    date: reader.readDateTimeOrNull(offsets[1]),
    id: id,
    letterToBaby: reader.readStringOrNull(offsets[2]),
    notes: reader.readStringOrNull(offsets[3]),
    photoPaths: reader.readStringList(offsets[4]),
    week: reader.readLong(offsets[5]),
    weightKg: reader.readDoubleOrNull(offsets[6]),
  );
  return object;
}

P _weekSnapshotDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringList(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weekSnapshotGetId(WeekSnapshot object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weekSnapshotGetLinks(WeekSnapshot object) {
  return [];
}

void _weekSnapshotAttach(
    IsarCollection<dynamic> col, Id id, WeekSnapshot object) {
  object.id = id;
}

extension WeekSnapshotByIndex on IsarCollection<WeekSnapshot> {
  Future<WeekSnapshot?> getByWeek(int week) {
    return getByIndex(r'week', [week]);
  }

  WeekSnapshot? getByWeekSync(int week) {
    return getByIndexSync(r'week', [week]);
  }

  Future<bool> deleteByWeek(int week) {
    return deleteByIndex(r'week', [week]);
  }

  bool deleteByWeekSync(int week) {
    return deleteByIndexSync(r'week', [week]);
  }

  Future<List<WeekSnapshot?>> getAllByWeek(List<int> weekValues) {
    final values = weekValues.map((e) => [e]).toList();
    return getAllByIndex(r'week', values);
  }

  List<WeekSnapshot?> getAllByWeekSync(List<int> weekValues) {
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

  Future<Id> putByWeek(WeekSnapshot object) {
    return putByIndex(r'week', object);
  }

  Id putByWeekSync(WeekSnapshot object, {bool saveLinks = true}) {
    return putByIndexSync(r'week', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWeek(List<WeekSnapshot> objects) {
    return putAllByIndex(r'week', objects);
  }

  List<Id> putAllByWeekSync(List<WeekSnapshot> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'week', objects, saveLinks: saveLinks);
  }
}

extension WeekSnapshotQueryWhereSort
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QWhere> {
  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhere> anyWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'week'),
      );
    });
  }
}

extension WeekSnapshotQueryWhere
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QWhereClause> {
  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> idBetween(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> weekEqualTo(
      int week) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'week',
        value: [week],
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> weekNotEqualTo(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> weekGreaterThan(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> weekLessThan(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterWhereClause> weekBetween(
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

extension WeekSnapshotQueryFilter
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QFilterCondition> {
  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      bellyGirthCmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bellyGirthCm',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      bellyGirthCmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bellyGirthCm',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      bellyGirthCmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bellyGirthCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      bellyGirthCmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bellyGirthCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      bellyGirthCmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bellyGirthCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      bellyGirthCmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bellyGirthCm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      dateGreaterThan(
    DateTime? value, {
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> dateLessThan(
    DateTime? value, {
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'letterToBaby',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'letterToBaby',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterToBaby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'letterToBaby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'letterToBaby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'letterToBaby',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'letterToBaby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'letterToBaby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'letterToBaby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'letterToBaby',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterToBaby',
        value: '',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      letterToBabyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'letterToBaby',
        value: '',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoPaths',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoPaths',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoPaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoPaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      photoPathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> weekEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'week',
        value: value,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> weekLessThan(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition> weekBetween(
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

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      weightKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weightKg',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      weightKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weightKg',
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      weightKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      weightKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      weightKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterFilterCondition>
      weightKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightKg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension WeekSnapshotQueryObject
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QFilterCondition> {}

extension WeekSnapshotQueryLinks
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QFilterCondition> {}

extension WeekSnapshotQuerySortBy
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QSortBy> {
  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByBellyGirthCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bellyGirthCm', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy>
      sortByBellyGirthCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bellyGirthCm', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByLetterToBaby() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterToBaby', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy>
      sortByLetterToBabyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterToBaby', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> sortByWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.desc);
    });
  }
}

extension WeekSnapshotQuerySortThenBy
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QSortThenBy> {
  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByBellyGirthCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bellyGirthCm', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy>
      thenByBellyGirthCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bellyGirthCm', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByLetterToBaby() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterToBaby', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy>
      thenByLetterToBabyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterToBaby', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.asc);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QAfterSortBy> thenByWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.desc);
    });
  }
}

extension WeekSnapshotQueryWhereDistinct
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> {
  QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> distinctByBellyGirthCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bellyGirthCm');
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> distinctByLetterToBaby(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'letterToBaby', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> distinctByPhotoPaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoPaths');
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> distinctByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'week');
    });
  }

  QueryBuilder<WeekSnapshot, WeekSnapshot, QDistinct> distinctByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightKg');
    });
  }
}

extension WeekSnapshotQueryProperty
    on QueryBuilder<WeekSnapshot, WeekSnapshot, QQueryProperty> {
  QueryBuilder<WeekSnapshot, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeekSnapshot, double?, QQueryOperations> bellyGirthCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bellyGirthCm');
    });
  }

  QueryBuilder<WeekSnapshot, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<WeekSnapshot, String?, QQueryOperations> letterToBabyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letterToBaby');
    });
  }

  QueryBuilder<WeekSnapshot, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<WeekSnapshot, List<String>?, QQueryOperations>
      photoPathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoPaths');
    });
  }

  QueryBuilder<WeekSnapshot, int, QQueryOperations> weekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'week');
    });
  }

  QueryBuilder<WeekSnapshot, double?, QQueryOperations> weightKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightKg');
    });
  }
}
