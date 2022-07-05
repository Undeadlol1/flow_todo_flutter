import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpsertGoalForm extends StatefulWidget {
  final Goal? goalToUpdate;
  const UpsertGoalForm({Key? key, this.goalToUpdate}) : super(key: key);

  @override
  State<UpsertGoalForm> createState() => _UpsertGoalFormState();
}

class _UpsertGoalFormState extends State<UpsertGoalForm> {
  static const _formControlName = 'title';

  String? _formError;

  late final _form = FormGroup(
    {
      _formControlName: FormControl<String>(
        value: widget.goalToUpdate == null ? '' : widget.goalToUpdate?.title,
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
                      autofocus: false,
                      formControlName: _formControlName,
                      validationMessages: _getValidationMessages,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: () => _handleSubmit(authState: authState),
                      decoration: InputDecoration(
                        errorText: _formError,
                        labelText: 'Enter your goal',
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

      if (widget.goalToUpdate == null) {
        titleFormControl.unfocus(touched: false);
        titleFormControl.value = null;
      }

      setState(() => _formError = null);

      try {
        if (widget.goalToUpdate == null) {
          // await GetIt.I<CreateTask>()(
          //   title: inputText,
          //   userId: authState.user.id,
          // );

          if (mounted) Navigator.of(context).pop();
        } else {
          //   widget.goalToUpdate!.copyWith(title: inputText),
          // );
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
