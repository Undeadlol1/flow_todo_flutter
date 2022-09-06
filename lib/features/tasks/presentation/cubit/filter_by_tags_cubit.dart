import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'filter_by_tags_state.dart';
part 'tags_cubit.freezed.dart';

@singleton
class FilterByTagsCubit extends Cubit<FilterByTagsState> {
  FilterByTagsCubit() : super(FilterByTagsState({}));

  void update(Set<String> tags) => emit(FilterByTagsState(tags));

  void reset() => emit(FilterByTagsState({}));
}
