import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpsertNote extends StatefulWidget {
  final String? note;
  final bool autoFocus;
  const UpsertNote({Key? key, this.note, this.autoFocus = false})
      : super(key: key);

  @override
  State<UpsertNote> createState() => _UpsertNoteState();
}

class _UpsertNoteState extends State<UpsertNote> {
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
          validators: [
            Validators.required,
            Validators.minLength(5),
            Validators.maxLength(1000)
          ], // custom validator
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
                      minLines: 3,
                      maxLines: 10,
                      autofocus: widget.autoFocus,
                      formControlName: _formControlName,
                      validationMessages: _getValidationMessages,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        errorText: _formError,
                        border: const UnderlineInputBorder(),
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
      final titleFormControl = _form.control(_formControlName);
      String? inputText = titleFormControl.value as String;

      titleFormControl.unfocus(touched: false);
      titleFormControl.value = null;
      setState(() => _formError = null);

      try {
        // await GetIt.I<CreateTask>()(
        //   title: inputText,
        //   userId: authState.user.id,
        // );
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
