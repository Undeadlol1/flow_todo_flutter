part of 'filter_by_tags_cubit.dart';

@freezed
class FilterByTagsState with _$FilterByTagsState {
  factory FilterByTagsState(Set<String> tags) = _State;
}
