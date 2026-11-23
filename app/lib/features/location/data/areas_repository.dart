import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/models/core_models.dart';
import 'package:save_it/core/supabase/supabase_client_provider.dart';

abstract class AreasRepository {
  Future<List<Area>> list();
}

class SupabaseAreasRepository implements AreasRepository {
  SupabaseAreasRepository(this._ref);

  final Ref _ref;

  @override
  Future<List<Area>> list() async {
    final client = _ref.read(supabaseClientProvider);
    if (client == null) {
      throw StateError('Supabase is not configured');
    }
    final rows = await client.from('areas').select().order('sort');
    return [
      for (final row in rows)
        Area.fromJson(Map<String, dynamic>.from(row as Map)),
    ];
  }
}

final areasRepositoryProvider = Provider<AreasRepository>(
  SupabaseAreasRepository.new,
);

class SearchOriginAreas extends AsyncNotifier<List<Area>> {
  @override
  Future<List<Area>> build() => ref.watch(areasRepositoryProvider).list();
}

final areasProvider = AsyncNotifierProvider<SearchOriginAreas, List<Area>>(
  SearchOriginAreas.new,
);
