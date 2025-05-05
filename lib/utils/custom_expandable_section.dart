import 'package:enrollment_system/pages/model/subject_select.dart';
import 'package:flutter/material.dart';

class CustomExpandableSection extends StatefulWidget {
  final String sectionName;
  final List<SubjectSelect> subjects;
  final bool isSelected;
  final ValueChanged<bool> onCheckboxChanged;

  const CustomExpandableSection({
    required this.sectionName,
    required this.subjects,
    required this.isSelected,
    required this.onCheckboxChanged,
    super.key,
  });

  @override
  State<CustomExpandableSection> createState() => _CustomExpandableSectionState();
}

class _CustomExpandableSectionState extends State<CustomExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final first = widget.subjects.isNotEmpty ? widget.subjects[0] : null;

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Row(
              children: [
                Expanded(child: Text(widget.sectionName, style: TextStyle(fontSize: 12))),
                Expanded(child: Text(first?.code ?? '', style: TextStyle(fontSize: 12))),
                Expanded(child: Text(first?.room ?? '', style: TextStyle(fontSize: 12))),
                Expanded(child: Text(first?.days ?? '', style: TextStyle(fontSize: 12))),

          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 20,
            ),
          ),

                SizedBox(width: 10),

                Expanded(child: Text(first?.time ?? '', style: TextStyle(fontSize: 12))),

                Checkbox(
                  value: widget.isSelected,
                  onChanged: (value) {
                    if (value != null) widget.onCheckboxChanged(value);
                  },
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          ...widget.subjects.skip(1).map((subject) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Row(
              children: [
                const Expanded(child: Text('')),
                Expanded(child: Text(subject.code)),
                Expanded(child: Text(subject.room)),
                Expanded(child: Text(subject.days)),
             //
                //   const SizedBox(width: 10), // arrow space
                Expanded(child: Text(subject.time)),
                const SizedBox(width: 30), // checkbox column stays empty
              ],
            ),
          )),
      ],
    );
  }
}
