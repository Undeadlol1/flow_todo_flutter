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
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
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
                      decoration: const InputDecoration(
                        labelText: 'Enter your task',
                        border: UnderlineInputBorder(),
                      ),
                      onSubmitted: () {
                        if (_form.valid && authState is Authenticated) {
                          GetIt.I<CreateTask>()(
                            userId: authState.user.id,
                            title: _form.value[_formControlName] as String,
                          );
                          _form.unfocus(touched: false);
                          _form.reset();
                          // _form.focus(_formControlName);
                          // _form.value = {_formControlName: null};
                          // debugPrint('SUBMITTED: ${_form.value[_formControlName]}');
                        }
                      },
                      validationMessages: (control) => {
                        ValidationMessage.required: 'Should not be empty',
                        ValidationMessage.minLength: 'Too short',
                        ValidationMessage.maxLength: 'Too long',
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
}
