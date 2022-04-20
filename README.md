# rho

A good looking todo app.

---

Focus on essential features — CRUD operations — as well as persisting data — hive, bloc, or again sqlite — and intuitive design — animations, decorations.

## demos

### empty_state

> create a decoration for the home screen and the instance in which there are no tasks

Show a string of text describing the empty state below a visual made up of three overlapping elements, two semi-transparent boxes and one solid icon.

Use `BackdropFilter` to blur the background of the topmost box and create a glass-like effect.

The widget receives optional arguments to customize the text, the icon and the color of the boxes and icons.

### text_input

> design the widget tree for the input area

Add a `Form` widget to receive user input. Use `TextFormField` with a dedicated controller and focus node.

The controller works to extract and manage the text in the field. The focus node helps to remove focus as the text is submitted.

_Please note:_ it is not necessary to remove focus on the `onFieldSubmitted` field.

### dialog_input

> prompt the text input with a dialog and through the fab

Manage the text input with a mixed state strategy:

- in the parent home widget consider the controller and focus node, so that it is ultimately possible to extract the text and manage the focus around the widget, not to mention the visibility of the fab component

- in the child widget update a boolean flag to highlight whether the text field is empty or not

Create the dialog with the `showGeneralDialog` function, but allow to dismiss the overlay with `barrierDismissible`. Animate the overlay with a sliding transition and collapse the overlay with the `Navigator` object.
