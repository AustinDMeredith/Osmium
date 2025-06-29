import 'package:flutter/material.dart';

void showAddProgressDialog(
  BuildContext context, {
  required void Function(String title, String description, double value) onSubmit,
  double initialValue = 0,
  double maxValue = double.infinity,
  String label = "Add Progress",
}) {
  final _formKey = GlobalKey<FormState>();
  double progress = initialValue;
  String progressTitle = '';
  String progressDescription = '';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(label),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Enter a title",
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter a title" : null,
                  onChanged: (value) => progressTitle = value,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Enter a description (optional)",
                  ),
                  maxLines: 2,
                  onChanged: (value) => progressDescription = value,
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: initialValue > 0 ? initialValue.toString() : '',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: "Progress Amount",
                    hintText: "Enter progress",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter a value";
                    final parsed = double.tryParse(value);
                    if (parsed == null) return "Enter a valid number";
                    if (parsed < 0) return "Value must be positive";
                    if (parsed > maxValue) return "Cannot exceed maximum";
                    return null;
                  },
                  onChanged: (value) {
                    progress = double.tryParse(value) ?? 0;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text("Add"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                onSubmit(progressTitle, progressDescription, progress);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}