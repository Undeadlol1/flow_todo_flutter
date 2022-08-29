import 'dart:developer';

import 'package:flutter/material.dart';

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({super.key});

  @override
  CreateTaskFormState createState() => CreateTaskFormState();
}

class CreateTaskFormState extends State<CreateTaskForm> {
  final _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final form = _formKey.currentState;
    if (form?.validate() ?? false) {
      print('Form is valid');
    } else {
      print('form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: _getPadding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              onEditingComplete: validateAndSave,
              decoration: const InputDecoration(
                // errorText: _formError,
                labelText: 'Enter your task',
                border: UnderlineInputBorder(),
              ),
              onChanged: (text) {},
              maxLength: 10,
              expands: true,
              validator: (text) {
                log('value: ${text.toString()}');
                final trimmedText = text?.trim() ?? '';

                if (trimmedText.isEmpty) {
                  return 'Must not be empty';
                }

                if (trimmedText.length < 3) {
                  return 'Too short';
                }

                if (trimmedText.length > 100) {
                  return 'Too long';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
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


  // void _handleSubmit({required AuthentificationState authState}) async {
  //   if (_form.valid && authState is Authenticated) {
  //     final titleFormControl = _form.control(_formControlName);
  //     String? inputText = titleFormControl.value as String;

  //     if (widget.taskToUpdate == null) {
  //       titleFormControl.unfocus(touched: false);
  //       titleFormControl.value = null;
  //     }

  //     setState(() => _formError = null);

  //     try {
  //       final navigator = Navigator.of(context);
  //       if (mounted && navigator.canPop()) {
  //         navigator.pop();
  //       }

  //       if (widget.taskToUpdate == null) {
  //         await GetIt.I<CreateTask>()(
  //           title: inputText,
  //           userId: authState.user.id,
  //         );
  //       } else {
  //         await GetIt.I<UpdateTask>()(
  //           widget.taskToUpdate!.copyWith(title: inputText),
  //         );
  //         GetIt.I<SnackbarService>().displaySnackbar(text: 'Saved!');
  //       }
  //     } catch (e) {
  //       titleFormControl.focus();
  //       titleFormControl.value = inputText;
  //       setState(() => _formError = e.toString());
  //       debugPrint(e.toString());
  //     }
  //   }
  // }

  // Map<String, String> _getValidationMessages(_) {
  //   return {
  //     ValidationMessage.maxLength: 'Too long',
  //     ValidationMessage.minLength: 'Too short',
  //     ValidationMessage.any: 'Something went wrong',
  //     ValidationMessage.required: 'Should not be empty',
  //   };
  // }

  // EdgeInsets _getPadding() {
  //   final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  //   return EdgeInsets.only(
  //     top: 10,
  //     left: 15,
  //     right: 15,
  //     bottom: keyboardHeight + 20,
  //   );
  // }

