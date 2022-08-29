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

  Set<String> tags = {};

  late final _form = FormGroup(
    {
      _formControlName: FormControl<String>(
        value: widget.taskToUpdate == null ? '' : widget.taskToUpdate?.title,
        validators: [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(100),
          _extractTagsToDisplayThem,
        ],
      ),
    },
  );

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
              if (_remoteConfig.getBool('are_tags_enabled') && tags.isNotEmpty)
                Column(
                  children: tags.map((tag) => Text(tag)).toList(),
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
            title: inputText,
            userId: authState.user.id,
          );
        } else {
          await GetIt.I<UpdateTask>()(
            widget.taskToUpdate!.copyWith(title: inputText),
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
    final tagsRegExp =
        RegExp(r'#([^\s]+)+', caseSensitive: false, multiLine: true);
    final Set<String> extractedTags = tagsRegExp
        .allMatches(control.value)
        .map((e) => e[1] ?? '')
        .map((e) => e.toLowerCase())
        .toSet();

    if (!setEquals(tags, extractedTags)) {
      setState(() => tags = extractedTags);
    }

    return null;
  }

  EdgeInsets _getPadding() {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return EdgeInsets.only(
      top: 10,
      left: 15,
      right: 15,
      bottom: keyboardHeight + 20,
    );
  }
}
