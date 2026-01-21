// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_visit.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDoctorVisitCollection on Isar {
  IsarCollection<DoctorVisit> get doctorVisits => this.collection();
}

const DoctorVisitSchema = CollectionSchema(
  name: r'DoctorVisit',
  id: -2124032609944485078,
  properties: {
    r'bpDiastolic': PropertySchema(
      id: 0,
      name: r'bpDiastolic',
      type: IsarType.long,
    ),
    r'bpSystolic': PropertySchema(
      id: 1,
      name: r'bpSystolic',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'doctorName': PropertySchema(
      id: 3,
      name: r'doctorName',
      type: IsarType.string,
    ),
    r'doctorNotes': PropertySchema(
      id: 4,
      name: r'doctorNotes',
      type: IsarType.string,
    ),
    r'isCompleted': PropertySchema(
      id: 5,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'questionsToAsk': PropertySchema(
      id: 6,
      name: r'questionsToAsk',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    ),
    r'weightKg': PropertySchema(
      id: 8,
      name: r'weightKg',
      type: IsarType.double,
    )
  },
  estimateSize: _doctorVisitEstimateSize,
  serialize: _doctorVisitSerialize,
  deserialize: _doctorVisitDeserialize,
  deserializeProp: _doctorVisitDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _doctorVisitGetId,
  getLinks: _doctorVisitGetLinks,
  attach: _doctorVisitAttach,
  version: '3.1.0+1',
);

int _doctorVisitEstimateSize(
  DoctorVisit object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.doctorName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.doctorNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.questionsToAsk;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _doctorVisitSerialize(
  DoctorVisit object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bpDiastolic);
  writer.writeLong(offsets[1], object.bpSystolic);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeString(offsets[3], object.doctorName);
  writer.writeString(offsets[4], object.doctorNotes);
  writer.writeBool(offsets[5], object.isCompleted);
  writer.writeString(offsets[6], object.questionsToAsk);
  writer.writeString(offsets[7], object.title);
  writer.writeDouble(offsets[8], object.weightKg);
}

DoctorVisit _doctorVisitDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DoctorVisit(
    bpDiastolic: reader.readLongOrNull(offsets[0]),
    bpSystolic: reader.readLongOrNull(offsets[1]),
    date: reader.readDateTime(offsets[2]),
    doctorName: reader.readStringOrNull(offsets[3]),
    doctorNotes: reader.readStringOrNull(offsets[4]),
    id: id,
    isCompleted: reader.readBoolOrNull(offsets[5]) ?? false,
    questionsToAsk: reader.readStringOrNull(offsets[6]),
    title: reader.readString(offsets[7]),
    weightKg: reader.readDoubleOrNull(offsets[8]),
  );
  return object;
}

P _doctorVisitDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _doctorVisitGetId(DoctorVisit object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _doctorVisitGetLinks(DoctorVisit object) {
  return [];
}

void _doctorVisitAttach(
    IsarCollection<dynamic> col, Id id, DoctorVisit object) {
  object.id = id;
}

extension DoctorVisitQueryWhereSort
    on QueryBuilder<DoctorVisit, DoctorVisit, QWhere> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DoctorVisitQueryWhere
    on QueryBuilder<DoctorVisit, DoctorVisit, QWhereClause> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> idBetween(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DoctorVisitQueryFilter
    on QueryBuilder<DoctorVisit, DoctorVisit, QFilterCondition> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpDiastolicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bpDiastolic',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpDiastolicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bpDiastolic',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpDiastolicEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bpDiastolic',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpDiastolicGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bpDiastolic',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpDiastolicLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bpDiastolic',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpDiastolicBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bpDiastolic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpSystolicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bpSystolic',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpSystolicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bpSystolic',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpSystolicEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bpSystolic',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpSystolicGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bpSystolic',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpSystolicLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bpSystolic',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      bpSystolicBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bpSystolic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'doctorName',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'doctorName',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doctorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'doctorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'doctorName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'doctorNotes',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'doctorNotes',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doctorNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doctorNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doctorNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'doctorNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'doctorNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'doctorNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'doctorNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      doctorNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'doctorNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionsToAsk',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionsToAsk',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionsToAsk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionsToAsk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionsToAsk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionsToAsk',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionsToAsk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionsToAsk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionsToAsk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionsToAsk',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionsToAsk',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      questionsToAskIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionsToAsk',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      weightKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weightKg',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
      weightKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weightKg',
      ));
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> weightKgEqualTo(
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition>
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

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterFilterCondition> weightKgBetween(
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

extension DoctorVisitQueryObject
    on QueryBuilder<DoctorVisit, DoctorVisit, QFilterCondition> {}

extension DoctorVisitQueryLinks
    on QueryBuilder<DoctorVisit, DoctorVisit, QFilterCondition> {}

extension DoctorVisitQuerySortBy
    on QueryBuilder<DoctorVisit, DoctorVisit, QSortBy> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByBpDiastolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDiastolic', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByBpDiastolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDiastolic', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByBpSystolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSystolic', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByBpSystolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSystolic', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDoctorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDoctorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDoctorNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorNotes', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByDoctorNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorNotes', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByQuestionsToAsk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionsToAsk', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy>
      sortByQuestionsToAskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionsToAsk', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> sortByWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.desc);
    });
  }
}

extension DoctorVisitQuerySortThenBy
    on QueryBuilder<DoctorVisit, DoctorVisit, QSortThenBy> {
  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByBpDiastolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDiastolic', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByBpDiastolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDiastolic', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByBpSystolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSystolic', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByBpSystolicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSystolic', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDoctorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDoctorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDoctorNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorNotes', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByDoctorNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorNotes', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByQuestionsToAsk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionsToAsk', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy>
      thenByQuestionsToAskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionsToAsk', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.asc);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QAfterSortBy> thenByWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.desc);
    });
  }
}

extension DoctorVisitQueryWhereDistinct
    on QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> {
  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByBpDiastolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bpDiastolic');
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByBpSystolic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bpSystolic');
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByDoctorName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doctorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByDoctorNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doctorNotes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByQuestionsToAsk(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionsToAsk',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorVisit, DoctorVisit, QDistinct> distinctByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightKg');
    });
  }
}

extension DoctorVisitQueryProperty
    on QueryBuilder<DoctorVisit, DoctorVisit, QQueryProperty> {
  QueryBuilder<DoctorVisit, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DoctorVisit, int?, QQueryOperations> bpDiastolicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bpDiastolic');
    });
  }

  QueryBuilder<DoctorVisit, int?, QQueryOperations> bpSystolicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bpSystolic');
    });
  }

  QueryBuilder<DoctorVisit, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DoctorVisit, String?, QQueryOperations> doctorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doctorName');
    });
  }

  QueryBuilder<DoctorVisit, String?, QQueryOperations> doctorNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doctorNotes');
    });
  }

  QueryBuilder<DoctorVisit, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<DoctorVisit, String?, QQueryOperations>
      questionsToAskProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionsToAsk');
    });
  }

  QueryBuilder<DoctorVisit, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<DoctorVisit, double?, QQueryOperations> weightKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightKg');
    });
  }
}
