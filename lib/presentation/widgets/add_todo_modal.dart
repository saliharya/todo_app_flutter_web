import 'package:flutter/material.dart';

class AddTodoModal extends StatefulWidget {
  final void Function(String title, bool completed) onSubmit;

  const AddTodoModal({super.key, required this.onSubmit});

  @override
  State<AddTodoModal> createState() => _AddTodoModalState();
}

class _AddTodoModalState extends State<AddTodoModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  bool _completed = false;

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_titleController.text, _completed);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Todo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Completed'),
                value: _completed,
                onChanged: (value) {
                  setState(() {
                    _completed = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
