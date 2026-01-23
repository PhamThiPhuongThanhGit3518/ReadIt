// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_table.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGenreCollection on Isar {
  IsarCollection<Genre> get genres => this.collection();
}

const GenreSchema = CollectionSchema(
  name: r'Genre',
  id: -453881181692258612,
  properties: {
    r'genreName': PropertySchema(
      id: 0,
      name: r'genreName',
      type: IsarType.string,
    ),
  },

  estimateSize: _genreEstimateSize,
  serialize: _genreSerialize,
  deserialize: _genreDeserialize,
  deserializeProp: _genreDeserializeProp,
  idName: r'id',
  indexes: {
    r'genreName': IndexSchema(
      id: -811775316327900368,
      name: r'genreName',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'genreName',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _genreGetId,
  getLinks: _genreGetLinks,
  attach: _genreAttach,
  version: '3.3.0',
);

int _genreEstimateSize(
  Genre object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.genreName.length * 3;
  return bytesCount;
}

void _genreSerialize(
  Genre object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.genreName);
}

Genre _genreDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Genre();
  object.genreName = reader.readString(offsets[0]);
  object.id = id;
  return object;
}

P _genreDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _genreGetId(Genre object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _genreGetLinks(Genre object) {
  return [];
}

void _genreAttach(IsarCollection<dynamic> col, Id id, Genre object) {
  object.id = id;
}

extension GenreByIndex on IsarCollection<Genre> {
  Future<Genre?> getByGenreName(String genreName) {
    return getByIndex(r'genreName', [genreName]);
  }

  Genre? getByGenreNameSync(String genreName) {
    return getByIndexSync(r'genreName', [genreName]);
  }

  Future<bool> deleteByGenreName(String genreName) {
    return deleteByIndex(r'genreName', [genreName]);
  }

  bool deleteByGenreNameSync(String genreName) {
    return deleteByIndexSync(r'genreName', [genreName]);
  }

  Future<List<Genre?>> getAllByGenreName(List<String> genreNameValues) {
    final values = genreNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'genreName', values);
  }

  List<Genre?> getAllByGenreNameSync(List<String> genreNameValues) {
    final values = genreNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'genreName', values);
  }

  Future<int> deleteAllByGenreName(List<String> genreNameValues) {
    final values = genreNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'genreName', values);
  }

  int deleteAllByGenreNameSync(List<String> genreNameValues) {
    final values = genreNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'genreName', values);
  }

  Future<Id> putByGenreName(Genre object) {
    return putByIndex(r'genreName', object);
  }

  Id putByGenreNameSync(Genre object, {bool saveLinks = true}) {
    return putByIndexSync(r'genreName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGenreName(List<Genre> objects) {
    return putAllByIndex(r'genreName', objects);
  }

  List<Id> putAllByGenreNameSync(List<Genre> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'genreName', objects, saveLinks: saveLinks);
  }
}

extension GenreQueryWhereSort on QueryBuilder<Genre, Genre, QWhere> {
  QueryBuilder<Genre, Genre, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GenreQueryWhere on QueryBuilder<Genre, Genre, QWhereClause> {
  QueryBuilder<Genre, Genre, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Genre, Genre, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> genreNameEqualTo(
    String genreName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'genreName', value: [genreName]),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> genreNameNotEqualTo(
    String genreName,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'genreName',
                lower: [],
                upper: [genreName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'genreName',
                lower: [genreName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'genreName',
                lower: [genreName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'genreName',
                lower: [],
                upper: [genreName],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension GenreQueryFilter on QueryBuilder<Genre, Genre, QFilterCondition> {
  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'genreName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'genreName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'genreName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'genreName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'genreName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'genreName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'genreName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'genreName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'genreName', value: ''),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> genreNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'genreName', value: ''),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension GenreQueryObject on QueryBuilder<Genre, Genre, QFilterCondition> {}

extension GenreQueryLinks on QueryBuilder<Genre, Genre, QFilterCondition> {}

extension GenreQuerySortBy on QueryBuilder<Genre, Genre, QSortBy> {
  QueryBuilder<Genre, Genre, QAfterSortBy> sortByGenreName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreName', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByGenreNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreName', Sort.desc);
    });
  }
}

extension GenreQuerySortThenBy on QueryBuilder<Genre, Genre, QSortThenBy> {
  QueryBuilder<Genre, Genre, QAfterSortBy> thenByGenreName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreName', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByGenreNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreName', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GenreQueryWhereDistinct on QueryBuilder<Genre, Genre, QDistinct> {
  QueryBuilder<Genre, Genre, QDistinct> distinctByGenreName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genreName', caseSensitive: caseSensitive);
    });
  }
}

extension GenreQueryProperty on QueryBuilder<Genre, Genre, QQueryProperty> {
  QueryBuilder<Genre, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Genre, String, QQueryOperations> genreNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genreName');
    });
  }
}
