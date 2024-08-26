import 'package:flutter/material.dart';

class ShowNotes extends StatefulWidget {
  const ShowNotes({super.key, required this.docid});

  final String docid;
  @override
  State<ShowNotes> createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
