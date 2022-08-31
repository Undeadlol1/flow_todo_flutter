import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'tags_state.dart';
part 'tags_cubit.freezed.dart';

@singleton
class TagsCubit extends Cubit<TagsState> {
  TagsCubit() : super(TagsState({}));

  void update(Set<String> tags) => emit(TagsState(tags));
}
