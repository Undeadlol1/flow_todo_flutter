import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GoToTaskCreation {
  final BuildContextProvider contextProvider;

  GoToTaskCreation({required this.contextProvider});

  void call() {
    contextProvider.call((context) {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return _ModalBody();
        },
      );
    });
  }
}

// TODO extract this
class _ModalBody extends StatefulWidget {
  _ModalBody({Key? key}) : super(key: key);

  @override
  State<_ModalBody> createState() => _ModalBodyState();
}

class _ModalBodyState extends State<_ModalBody> {
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
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
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
                    if (_form.valid) {
                      debugPrint('SUBMITTED: ${_form.value[_formControlName]}');
                      _form.unfocus(touched: false);
                      _form.reset();
                      // _form.focus(_formControlName);
                      // _form.value = {_formControlName: null};
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
  }
}
