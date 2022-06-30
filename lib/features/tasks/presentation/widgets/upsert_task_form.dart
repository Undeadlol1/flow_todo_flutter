import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/update_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';

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

  String? _formError;

  late final _form = FormGroup(
    {
      _formControlName: FormControl<String>(
        value: widget.taskToUpdate == null ? '' : widget.taskToUpdate?.title,
        validators: [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(100)
        ], // custom validator
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

      titleFormControl.unfocus(touched: false);
      titleFormControl.value = null;
      setState(() => _formError = null);

      try {
        widget.taskToUpdate == null
            ? await GetIt.I<CreateTask>()(
                title: inputText,
                userId: authState.user.id,
              )
            : await GetIt.I<UpdateTask>()(
                widget.taskToUpdate!.copyWith(title: inputText),
              );
        if (mounted) Navigator.of(context).pop();
      } catch (e) {
        titleFormControl.focus();
        titleFormControl.value = inputText;
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
