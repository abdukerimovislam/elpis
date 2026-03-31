// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregnancy_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPregnancySettingsCollection on Isar {
  IsarCollection<PregnancySettings> get pregnancySettings => this.collection();
}

const PregnancySettingsSchema = CollectionSchema(
  name: r'PregnancySettings',
  id: 2028410448803126111,
  properties: {
    r'babyName': PropertySchema(
      id: 0,
      name: r'babyName',
      type: IsarType.string,
    ),
    r'currentWeek': PropertySchema(
      id: 1,
      name: r'currentWeek',
      type: IsarType.long,
    ),
    r'doctorPhone': PropertySchema(
      id: 2,
      name: r'doctorPhone',
      type: IsarType.string,
    ),
    r'effectiveVisualModeKey': PropertySchema(
      id: 3,
      name: r'effectiveVisualModeKey',
      type: IsarType.string,
    ),
    r'estimatedDueDate': PropertySchema(
      id: 4,
      name: r'estimatedDueDate',
      type: IsarType.dateTime,
    ),
    r'heightCm': PropertySchema(
      id: 5,
      name: r'heightCm',
      type: IsarType.double,
    ),
    r'hospitalAddress': PropertySchema(
      id: 6,
      name: r'hospitalAddress',
      type: IsarType.string,
    ),
    r'isFruitMode': PropertySchema(
      id: 7,
      name: r'isFruitMode',
      type: IsarType.bool,
    ),
    r'isLaborMode': PropertySchema(
      id: 8,
      name: r'isLaborMode',
      type: IsarType.bool,
    ),
    r'languageCode': PropertySchema(
      id: 9,
      name: r'languageCode',
      type: IsarType.string,
    ),
    r'partnerName': PropertySchema(
      id: 10,
      name: r'partnerName',
      type: IsarType.string,
    ),
    r'partnerPhone': PropertySchema(
      id: 11,
      name: r'partnerPhone',
      type: IsarType.string,
    ),
    r'prePregnancyWeightKg': PropertySchema(
      id: 12,
      name: r'prePregnancyWeightKg',
      type: IsarType.double,
    ),
    r'showLaborButton': PropertySchema(
      id: 13,
      name: r'showLaborButton',
      type: IsarType.bool,
    ),
    r'themeKey': PropertySchema(
      id: 14,
      name: r'themeKey',
      type: IsarType.string,
    ),
    r'visualModeKey': PropertySchema(
      id: 15,
      name: r'visualModeKey',
      type: IsarType.string,
    )
  },
  estimateSize: _pregnancySettingsEstimateSize,
  serialize: _pregnancySettingsSerialize,
  deserialize: _pregnancySettingsDeserialize,
  deserializeProp: _pregnancySettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _pregnancySettingsGetId,
  getLinks: _pregnancySettingsGetLinks,
  attach: _pregnancySettingsAttach,
  version: '3.1.0+1',
);

int _pregnancySettingsEstimateSize(
  PregnancySettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.babyName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.doctorPhone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.effectiveVisualModeKey.length * 3;
  {
    final value = object.hospitalAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.languageCode.length * 3;
  {
    final value = object.partnerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.partnerPhone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.themeKey.length * 3;
  bytesCount += 3 + object.visualModeKey.length * 3;
  return bytesCount;
}

void _pregnancySettingsSerialize(
  PregnancySettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.babyName);
  writer.writeLong(offsets[1], object.currentWeek);
  writer.writeString(offsets[2], object.doctorPhone);
  writer.writeString(offsets[3], object.effectiveVisualModeKey);
  writer.writeDateTime(offsets[4], object.estimatedDueDate);
  writer.writeDouble(offsets[5], object.heightCm);
  writer.writeString(offsets[6], object.hospitalAddress);
  writer.writeBool(offsets[7], object.isFruitMode);
  writer.writeBool(offsets[8], object.isLaborMode);
  writer.writeString(offsets[9], object.languageCode);
  writer.writeString(offsets[10], object.partnerName);
  writer.writeString(offsets[11], object.partnerPhone);
  writer.writeDouble(offsets[12], object.prePregnancyWeightKg);
  writer.writeBool(offsets[13], object.showLaborButton);
  writer.writeString(offsets[14], object.themeKey);
  writer.writeString(offsets[15], object.visualModeKey);
}

PregnancySettings _pregnancySettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PregnancySettings(
    babyName: reader.readStringOrNull(offsets[0]),
    doctorPhone: reader.readStringOrNull(offsets[2]),
    estimatedDueDate: reader.readDateTime(offsets[4]),
    heightCm: reader.readDoubleOrNull(offsets[5]),
    hospitalAddress: reader.readStringOrNull(offsets[6]),
    isFruitMode: reader.readBoolOrNull(offsets[7]) ?? true,
    isLaborMode: reader.readBoolOrNull(offsets[8]) ?? false,
    languageCode: reader.readStringOrNull(offsets[9]) ?? 'en',
    partnerName: reader.readStringOrNull(offsets[10]),
    partnerPhone: reader.readStringOrNull(offsets[11]),
    prePregnancyWeightKg: reader.readDoubleOrNull(offsets[12]),
    showLaborButton: reader.readBoolOrNull(offsets[13]) ?? true,
    themeKey: reader.readStringOrNull(offsets[14]) ?? 'serenity',
    visualModeKey: reader.readStringOrNull(offsets[15]) ??
        PregnancySettings.visualModeFruit,
  );
  object.id = id;
  return object;
}

P _pregnancySettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? 'en') as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? 'serenity') as P;
    case 15:
      return (reader.readStringOrNull(offset) ??
          PregnancySettings.visualModeFruit) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pregnancySettingsGetId(PregnancySettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pregnancySettingsGetLinks(
    PregnancySettings object) {
  return [];
}

void _pregnancySettingsAttach(
    IsarCollection<dynamic> col, Id id, PregnancySettings object) {
  object.id = id;
}

extension PregnancySettingsQueryWhereSort
    on QueryBuilder<PregnancySettings, PregnancySettings, QWhere> {
  QueryBuilder<PregnancySettings, PregnancySettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PregnancySettingsQueryWhere
    on QueryBuilder<PregnancySettings, PregnancySettings, QWhereClause> {
  QueryBuilder<PregnancySettings, PregnancySettings, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterWhereClause>
      idBetween(
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
}

extension PregnancySettingsQueryFilter
    on QueryBuilder<PregnancySettings, PregnancySettings, QFilterCondition> {
  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'babyName',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'babyName',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'babyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'babyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'babyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'babyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'babyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'babyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'babyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'babyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'babyName',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      babyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'babyName',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      currentWeekEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      currentWeekGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      currentWeekLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      currentWeekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'doctorPhone',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'doctorPhone',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doctorPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doctorPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doctorPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'doctorPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'doctorPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'doctorPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'doctorPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      doctorPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'doctorPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'effectiveVisualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'effectiveVisualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'effectiveVisualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'effectiveVisualModeKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'effectiveVisualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'effectiveVisualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'effectiveVisualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'effectiveVisualModeKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'effectiveVisualModeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      effectiveVisualModeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'effectiveVisualModeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      estimatedDueDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimatedDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      estimatedDueDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimatedDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      estimatedDueDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimatedDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      estimatedDueDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimatedDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      heightCmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      heightCmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      heightCmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      heightCmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      heightCmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      heightCmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heightCm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hospitalAddress',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hospitalAddress',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hospitalAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hospitalAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hospitalAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hospitalAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hospitalAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hospitalAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hospitalAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hospitalAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hospitalAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      hospitalAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hospitalAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      isFruitModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFruitMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      isLaborModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLaborMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'languageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'languageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      languageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partnerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'partnerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerPhone',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerPhone',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partnerPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'partnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'partnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'partnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'partnerPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      partnerPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'partnerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      prePregnancyWeightKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'prePregnancyWeightKg',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      prePregnancyWeightKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'prePregnancyWeightKg',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      prePregnancyWeightKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prePregnancyWeightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      prePregnancyWeightKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prePregnancyWeightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      prePregnancyWeightKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prePregnancyWeightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      prePregnancyWeightKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prePregnancyWeightKg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      showLaborButtonEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showLaborButton',
        value: value,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'themeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'themeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'themeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'themeKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      themeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'themeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'visualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'visualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'visualModeKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'visualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'visualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'visualModeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'visualModeKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visualModeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterFilterCondition>
      visualModeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'visualModeKey',
        value: '',
      ));
    });
  }
}

extension PregnancySettingsQueryObject
    on QueryBuilder<PregnancySettings, PregnancySettings, QFilterCondition> {}

extension PregnancySettingsQueryLinks
    on QueryBuilder<PregnancySettings, PregnancySettings, QFilterCondition> {}

extension PregnancySettingsQuerySortBy
    on QueryBuilder<PregnancySettings, PregnancySettings, QSortBy> {
  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByBabyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'babyName', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByBabyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'babyName', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByCurrentWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeek', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByCurrentWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeek', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByDoctorPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorPhone', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByDoctorPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorPhone', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByEffectiveVisualModeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveVisualModeKey', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByEffectiveVisualModeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveVisualModeKey', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByEstimatedDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedDueDate', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByEstimatedDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedDueDate', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByHospitalAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospitalAddress', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByHospitalAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospitalAddress', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByIsFruitMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFruitMode', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByIsFruitModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFruitMode', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByIsLaborMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLaborMode', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByIsLaborModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLaborMode', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByPartnerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerPhone', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByPartnerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerPhone', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByPrePregnancyWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prePregnancyWeightKg', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByPrePregnancyWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prePregnancyWeightKg', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByShowLaborButton() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLaborButton', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByShowLaborButtonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLaborButton', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByThemeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeKey', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByThemeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeKey', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByVisualModeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualModeKey', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      sortByVisualModeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualModeKey', Sort.desc);
    });
  }
}

extension PregnancySettingsQuerySortThenBy
    on QueryBuilder<PregnancySettings, PregnancySettings, QSortThenBy> {
  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByBabyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'babyName', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByBabyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'babyName', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByCurrentWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeek', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByCurrentWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeek', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByDoctorPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorPhone', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByDoctorPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorPhone', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByEffectiveVisualModeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveVisualModeKey', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByEffectiveVisualModeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveVisualModeKey', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByEstimatedDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedDueDate', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByEstimatedDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedDueDate', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByHospitalAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospitalAddress', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByHospitalAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospitalAddress', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByIsFruitMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFruitMode', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByIsFruitModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFruitMode', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByIsLaborMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLaborMode', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByIsLaborModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLaborMode', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByPartnerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerPhone', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByPartnerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerPhone', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByPrePregnancyWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prePregnancyWeightKg', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByPrePregnancyWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prePregnancyWeightKg', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByShowLaborButton() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLaborButton', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByShowLaborButtonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLaborButton', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByThemeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeKey', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByThemeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeKey', Sort.desc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByVisualModeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualModeKey', Sort.asc);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QAfterSortBy>
      thenByVisualModeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualModeKey', Sort.desc);
    });
  }
}

extension PregnancySettingsQueryWhereDistinct
    on QueryBuilder<PregnancySettings, PregnancySettings, QDistinct> {
  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByBabyName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'babyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByCurrentWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentWeek');
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByDoctorPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doctorPhone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByEffectiveVisualModeKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'effectiveVisualModeKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByEstimatedDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimatedDueDate');
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heightCm');
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByHospitalAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hospitalAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByIsFruitMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFruitMode');
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByIsLaborMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLaborMode');
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByLanguageCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'languageCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByPartnerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByPartnerPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerPhone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByPrePregnancyWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prePregnancyWeightKg');
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByShowLaborButton() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showLaborButton');
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByThemeKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PregnancySettings, PregnancySettings, QDistinct>
      distinctByVisualModeKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visualModeKey',
          caseSensitive: caseSensitive);
    });
  }
}

extension PregnancySettingsQueryProperty
    on QueryBuilder<PregnancySettings, PregnancySettings, QQueryProperty> {
  QueryBuilder<PregnancySettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PregnancySettings, String?, QQueryOperations>
      babyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'babyName');
    });
  }

  QueryBuilder<PregnancySettings, int, QQueryOperations> currentWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentWeek');
    });
  }

  QueryBuilder<PregnancySettings, String?, QQueryOperations>
      doctorPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doctorPhone');
    });
  }

  QueryBuilder<PregnancySettings, String, QQueryOperations>
      effectiveVisualModeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'effectiveVisualModeKey');
    });
  }

  QueryBuilder<PregnancySettings, DateTime, QQueryOperations>
      estimatedDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimatedDueDate');
    });
  }

  QueryBuilder<PregnancySettings, double?, QQueryOperations>
      heightCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heightCm');
    });
  }

  QueryBuilder<PregnancySettings, String?, QQueryOperations>
      hospitalAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hospitalAddress');
    });
  }

  QueryBuilder<PregnancySettings, bool, QQueryOperations>
      isFruitModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFruitMode');
    });
  }

  QueryBuilder<PregnancySettings, bool, QQueryOperations>
      isLaborModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLaborMode');
    });
  }

  QueryBuilder<PregnancySettings, String, QQueryOperations>
      languageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'languageCode');
    });
  }

  QueryBuilder<PregnancySettings, String?, QQueryOperations>
      partnerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerName');
    });
  }

  QueryBuilder<PregnancySettings, String?, QQueryOperations>
      partnerPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerPhone');
    });
  }

  QueryBuilder<PregnancySettings, double?, QQueryOperations>
      prePregnancyWeightKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prePregnancyWeightKg');
    });
  }

  QueryBuilder<PregnancySettings, bool, QQueryOperations>
      showLaborButtonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showLaborButton');
    });
  }

  QueryBuilder<PregnancySettings, String, QQueryOperations> themeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeKey');
    });
  }

  QueryBuilder<PregnancySettings, String, QQueryOperations>
      visualModeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visualModeKey');
    });
  }
}
