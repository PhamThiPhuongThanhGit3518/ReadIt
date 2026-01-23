import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../database/isar_service.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final service = IsarService();
  return await service.isar;
});