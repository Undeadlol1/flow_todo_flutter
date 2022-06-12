import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({Key? key}) : super(key: key);

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  static const _formControlName = 'title';

  final _createTask = GetIt.I<CreateTask>();

  final _form = FormGroup(
    {
      _formControlName: FormControl<String>(
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
                      decoration: const InputDecoration(
                        labelText: 'Enter your task',
                        border: UnderlineInputBorder(),
                      ),
                      onSubmitted: () => _handleSubmit(authState: authState),
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

  void _handleSubmit({required AuthentificationState authState}) {
    if (_form.valid && authState is Authenticated) {
      try {
        _createTask(
          userId: authState.user.id,
          title: _form.value[_formControlName] as String,
        );
      } catch (e) {
        _form.controls[_formControlName]?.setErrors({
          ValidationMessage.any: false,
        });
      }
    }
  }

  Map<String, String> _getValidationMessages(_) {
    return {
      ValidationMessage.any: 'Something went wrong',
      ValidationMessage.required: 'Should not be empty',
      ValidationMessage.minLength: 'Too short',
      ValidationMessage.maxLength: 'Too long',
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
