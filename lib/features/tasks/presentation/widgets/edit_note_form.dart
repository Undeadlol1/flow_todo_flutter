import 'dart:developer';

import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../domain/use_cases/update_task_note.dart';

class EditNoteForm extends StatefulWidget {
  final Task task;
  final String? note;
  final bool autoFocus;
  const EditNoteForm({
    Key? key,
    required this.task,
    this.note,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<EditNoteForm> createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm> {
  static const _formControlName = 'note';

  String? _formError;

  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup(
      {
        _formControlName: FormControl<String>(
          value: widget.note,
          validators: [Validators.maxLength(1000)], // custom validator
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
        return CardView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ReactiveForm(
                formGroup: _form,
                child: Column(
                  children: <Widget>[
                    ReactiveTextField(
                      minLines: 3,
                      maxLines: 10,
                      autofocus: widget.autoFocus,
                      formControlName: _formControlName,
                      validationMessages: _getValidationMessages,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        errorText: _formError,
                        border: const UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Builder(
                      builder: (context) {
                        final form = ReactiveForm.of(context);
                        return ElevatedButton(
                          onPressed: form?.valid ?? false
                              ? () {
                                  log('form $form');
                                  _handleSubmit(
                                    authState: authState,
                                  );
                                }
                              : null,
                          child: const Text('Save'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSubmit({
    required AuthentificationState authState,
  }) async {
    if (_form.valid && authState is Authenticated) {
      final noteFormControl = _form.control(_formControlName);
      String? inputText = noteFormControl.value as String;

      setState(() => _formError = null);

      try {
        await GetIt.I<UpdateTaskNote>()(
          note: inputText,
          task: widget.task,
        );
        GetIt.I<SnackbarService>().displaySnackbar(text: 'Saved!');
      } catch (e) {
        noteFormControl.focus();
        noteFormControl.value = inputText;
        setState(() => _formError = e.toString());
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
}
