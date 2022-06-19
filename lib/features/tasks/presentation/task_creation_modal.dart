import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({Key? key}) : super(key: key);

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  static const _formControlName = 'title';

  String? _formError;

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
                      decoration: InputDecoration(
                        labelText: 'Enter your task',
                        border: const UnderlineInputBorder(),
                        errorText: _formError,
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

  void _handleSubmit({required AuthentificationState authState}) async {
    if (_form.valid && authState is Authenticated) {
      final titleInput = _form.control(_formControlName);
      String? inputText = titleInput.value as String;

      titleInput.unfocus(touched: false);
      titleInput.value = null;
      setState(() => _formError = null);

      try {
        await GetIt.I<CreateTask>()(
          title: inputText,
          userId: authState.user.id,
        );
      } catch (e) {
        titleInput.focus();
        titleInput.value = inputText;
        setState(() => _formError = e.toString());
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
