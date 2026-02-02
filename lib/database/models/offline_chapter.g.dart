// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_chapter.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOfflineChapterCollection on Isar {
  IsarCollection<OfflineChapter> get offlineChapters => this.collection();
}

const OfflineChapterSchema = CollectionSchema(
  name: r'OfflineChapter',
  id: 762647193431632591,
  properties: {
    r'chapterId': PropertySchema(
      id: 0,
      name: r'chapterId',
      type: IsarType.long,
    ),
    r'chapterTitle': PropertySchema(
      id: 1,
      name: r'chapterTitle',
      type: IsarType.string,
    ),
    r'content': PropertySchema(id: 2, name: r'content', type: IsarType.string),
    r'downloadedAt': PropertySchema(
      id: 3,
      name: r'downloadedAt',
      type: IsarType.dateTime,
    ),
    r'orderNum': PropertySchema(id: 4, name: r'orderNum', type: IsarType.long),
    r'storyId': PropertySchema(id: 5, name: r'storyId', type: IsarType.long),
    r'storyName': PropertySchema(
      id: 6,
      name: r'storyName',
      type: IsarType.string,
    ),
  },

  estimateSize: _offlineChapterEstimateSize,
  serialize: _offlineChapterSerialize,
  deserialize: _offlineChapterDeserialize,
  deserializeProp: _offlineChapterDeserializeProp,
  idName: r'id',
  indexes: {
    r'storyId': IndexSchema(
      id: -7904996416186759579,
      name: r'storyId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'storyId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'chapterId': IndexSchema(
      id: -1917949875430644359,
      name: r'chapterId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'chapterId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _offlineChapterGetId,
  getLinks: _offlineChapterGetLinks,
  attach: _offlineChapterAttach,
  version: '3.3.0',
);

int _offlineChapterEstimateSize(
  OfflineChapter object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.chapterTitle.length * 3;
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.storyName.length * 3;
  return bytesCount;
}

void _offlineChapterSerialize(
  OfflineChapter object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.chapterId);
  writer.writeString(offsets[1], object.chapterTitle);
  writer.writeString(offsets[2], object.content);
  writer.writeDateTime(offsets[3], object.downloadedAt);
  writer.writeLong(offsets[4], object.orderNum);
  writer.writeLong(offsets[5], object.storyId);
  writer.writeString(offsets[6], object.storyName);
}

OfflineChapter _offlineChapterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OfflineChapter(
    chapterId: reader.readLong(offsets[0]),
    chapterTitle: reader.readString(offsets[1]),
    content: reader.readString(offsets[2]),
    downloadedAt: reader.readDateTime(offsets[3]),
    orderNum: reader.readLong(offsets[4]),
    storyId: reader.readLong(offsets[5]),
    storyName: reader.readString(offsets[6]),
  );
  object.id = id;
  return object;
}

P _offlineChapterDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _offlineChapterGetId(OfflineChapter object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _offlineChapterGetLinks(OfflineChapter object) {
  return [];
}

void _offlineChapterAttach(
  IsarCollection<dynamic> col,
  Id id,
  OfflineChapter object,
) {
  object.id = id;
}

extension OfflineChapterQueryWhereSort
    on QueryBuilder<OfflineChapter, OfflineChapter, QWhere> {
  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhere> anyStoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'storyId'),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhere> anyChapterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'chapterId'),
      );
    });
  }
}

extension OfflineChapterQueryWhere
    on QueryBuilder<OfflineChapter, OfflineChapter, QWhereClause> {
  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause> idBetween(
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

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  storyIdEqualTo(int storyId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'storyId', value: [storyId]),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  storyIdNotEqualTo(int storyId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'storyId',
                lower: [],
                upper: [storyId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'storyId',
                lower: [storyId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'storyId',
                lower: [storyId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'storyId',
                lower: [],
                upper: [storyId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  storyIdGreaterThan(int storyId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'storyId',
          lower: [storyId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  storyIdLessThan(int storyId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'storyId',
          lower: [],
          upper: [storyId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  storyIdBetween(
    int lowerStoryId,
    int upperStoryId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'storyId',
          lower: [lowerStoryId],
          includeLower: includeLower,
          upper: [upperStoryId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  chapterIdEqualTo(int chapterId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'chapterId', value: [chapterId]),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  chapterIdNotEqualTo(int chapterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'chapterId',
                lower: [],
                upper: [chapterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'chapterId',
                lower: [chapterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'chapterId',
                lower: [chapterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'chapterId',
                lower: [],
                upper: [chapterId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  chapterIdGreaterThan(int chapterId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'chapterId',
          lower: [chapterId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  chapterIdLessThan(int chapterId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'chapterId',
          lower: [],
          upper: [chapterId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterWhereClause>
  chapterIdBetween(
    int lowerChapterId,
    int upperChapterId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'chapterId',
          lower: [lowerChapterId],
          includeLower: includeLower,
          upper: [upperChapterId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension OfflineChapterQueryFilter
    on QueryBuilder<OfflineChapter, OfflineChapter, QFilterCondition> {
  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'chapterId', value: value),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chapterId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chapterId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chapterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'chapterTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chapterTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chapterTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chapterTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'chapterTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'chapterTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'chapterTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'chapterTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'chapterTitle', value: ''),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  chapterTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'chapterTitle', value: ''),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'content',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'content',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'content', value: ''),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'content', value: ''),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  downloadedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'downloadedAt', value: value),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  downloadedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'downloadedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  downloadedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'downloadedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  downloadedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'downloadedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition> idBetween(
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

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  orderNumEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'orderNum', value: value),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  orderNumGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'orderNum',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  orderNumLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'orderNum',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  orderNumBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'orderNum',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'storyId', value: value),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'storyId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'storyId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'storyId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'storyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'storyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'storyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'storyName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'storyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'storyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'storyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'storyName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'storyName', value: ''),
      );
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterFilterCondition>
  storyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'storyName', value: ''),
      );
    });
  }
}

extension OfflineChapterQueryObject
    on QueryBuilder<OfflineChapter, OfflineChapter, QFilterCondition> {}

extension OfflineChapterQueryLinks
    on QueryBuilder<OfflineChapter, OfflineChapter, QFilterCondition> {}

extension OfflineChapterQuerySortBy
    on QueryBuilder<OfflineChapter, OfflineChapter, QSortBy> {
  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> sortByChapterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterId', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByChapterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterId', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByDownloadedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> sortByOrderNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByOrderNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> sortByStoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByStoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> sortByStoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyName', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  sortByStoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyName', Sort.desc);
    });
  }
}

extension OfflineChapterQuerySortThenBy
    on QueryBuilder<OfflineChapter, OfflineChapter, QSortThenBy> {
  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> thenByChapterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterId', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByChapterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterId', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByDownloadedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> thenByOrderNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByOrderNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> thenByStoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByStoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.desc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy> thenByStoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyName', Sort.asc);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QAfterSortBy>
  thenByStoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyName', Sort.desc);
    });
  }
}

extension OfflineChapterQueryWhereDistinct
    on QueryBuilder<OfflineChapter, OfflineChapter, QDistinct> {
  QueryBuilder<OfflineChapter, OfflineChapter, QDistinct>
  distinctByChapterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterId');
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QDistinct>
  distinctByChapterTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QDistinct> distinctByContent({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QDistinct>
  distinctByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadedAt');
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QDistinct> distinctByOrderNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderNum');
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QDistinct> distinctByStoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storyId');
    });
  }

  QueryBuilder<OfflineChapter, OfflineChapter, QDistinct> distinctByStoryName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storyName', caseSensitive: caseSensitive);
    });
  }
}

extension OfflineChapterQueryProperty
    on QueryBuilder<OfflineChapter, OfflineChapter, QQueryProperty> {
  QueryBuilder<OfflineChapter, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OfflineChapter, int, QQueryOperations> chapterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterId');
    });
  }

  QueryBuilder<OfflineChapter, String, QQueryOperations>
  chapterTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterTitle');
    });
  }

  QueryBuilder<OfflineChapter, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<OfflineChapter, DateTime, QQueryOperations>
  downloadedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadedAt');
    });
  }

  QueryBuilder<OfflineChapter, int, QQueryOperations> orderNumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderNum');
    });
  }

  QueryBuilder<OfflineChapter, int, QQueryOperations> storyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storyId');
    });
  }

  QueryBuilder<OfflineChapter, String, QQueryOperations> storyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storyName');
    });
  }
}
