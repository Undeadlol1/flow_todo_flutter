import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/update_task.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/services/snackbar_service.dart';
import '../../domain/models/task.dart';
import '../../domain/use_cases/create_task.dart';

class UpsertTaskForm extends StatefulWidget {
  final Task? taskToUpdate;
  const UpsertTaskForm({Key? key, this.taskToUpdate}) : super(key: key);

  @override
  State<UpsertTaskForm> createState() => _UpsertTaskFormState();
}

class _UpsertTaskFormState extends State<UpsertTaskForm> {
  static const _formControlName = 'title';

  static final _remoteConfig = GetIt.I<FirebaseRemoteConfig>();
  String? _formError;

  late final FormGroup _form;

  static final _tagsRegExp =
      RegExp(r'#([^\s]+)+', caseSensitive: false, multiLine: true);

  List<String> tags = [];

  @override
  void initState() {
    super.initState();

    String title =
        widget.taskToUpdate == null ? '' : widget.taskToUpdate?.title ?? '';

    for (var tag in widget.taskToUpdate?.tags ?? []) {
      title = '$title #$tag';
    }

    _form = FormGroup(
      {
        _formControlName: FormControl<String>(
          value: title,
          validators: [
            Validators.required,
            Validators.minLength(3),
            Validators.maxLength(100),
            _extractTagsToDisplayThem,
          ],
        ),
      },
    );
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (context, authState) {
        return Padding(
          padding: _getPadding(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ReactiveForm(
                formGroup: _form,
                child: Column(
                  children: <Widget>[
                    ReactiveTextField(
                      autofocus: true,
                      formControlName: _formControlName,
                      validationMessages: _getValidationMessages,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: () => _handleSubmit(authState: authState),
                      decoration: InputDecoration(
                        errorText: _formError,
                        labelText: 'Enter your task',
                        border: const UnderlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              if (_remoteConfig.getBool('are_tags_enabled'))
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Hint: you can add tags via hashtags. '
                      'Enter space, hashtag and your tag. '
                      'Like so: "My task text #first #second".',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    _Tags(tags: tags)
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  void _handleSubmit({required AuthentificationState authState}) async {
    if (_form.valid && authState is Authenticated) {
      final titleFormControl = _form.control(_formControlName);
      String? inputText = titleFormControl.value as String;
      final taskTags = _extractTagsFromText(inputText);
      final String title = inputText.replaceAll(_tagsRegExp, '').trim();

      if (widget.taskToUpdate == null) {
        titleFormControl.unfocus(touched: false);
        titleFormControl.value = null;
      }

      setState(() => _formError = null);

      try {
        final navigator = Navigator.of(context);
        if (mounted && navigator.canPop()) {
          navigator.pop();
        }

        if (widget.taskToUpdate == null) {
          await GetIt.I<CreateTask>()(
            title: title,
            tags: taskTags,
            userId: authState.user.id,
          );
        } else {
          await GetIt.I<UpdateTask>()(
            widget.taskToUpdate!.copyWith(title: title, tags: tags),
          );
          GetIt.I<SnackbarService>().displaySnackbar(text: 'Saved!');
        }
      } catch (e) {
        titleFormControl.focus();
        titleFormControl.value = inputText;
        setState(() => _formError = e.toString());
        debugPrint(e.toString());
      }
    }
  }

  Map<String, String> _getValidationMessages(_) {
    return {
      ValidationMessage.maxLength: 'Too long',
      ValidationMessage.minLength: 'Too short',
      ValidationMessage.any: 'Something went wrong',
      ValidationMessage.required: 'Should not be empty',
    };
  }

  Map<String, dynamic>? _extractTagsToDisplayThem(
    AbstractControl<dynamic> control,
  ) {
    final String text = control.value ?? '';
    List<String> extractedTags = _extractTagsFromText(text);

    if (!listEquals(tags, extractedTags)) {
      setState(() => tags = extractedTags);
    }

    return null;
  }

  List<String> _extractTagsFromText(String text) {
    return _tagsRegExp
        .allMatches(text)
        .map((e) => e[1] ?? '')
        .map((e) => e.toLowerCase())
        .toSet()
        .toList();
  }

  EdgeInsets _getPadding() {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return EdgeInsets.only(
      top: 10,
      left: 15,
      right: 15,
      bottom: keyboardHeight,
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({
    Key? key,
    required List<String> tags,
  })  : _tags = tags,
        super(key: key);

  final List<String> _tags;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _tags.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Wrap(
                children: _tags
                    .map(
                      (tag) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Chip(
                          label: Text(tag),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          : const SizedBox(),
    );
  }
}
