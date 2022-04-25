# rho

A good looking task-taking app.

---

## figma

The `figma` sub-folder describes the idea of the final output, both in design and features.

In the current version the idea is to support CRUD-like operations:

- create

- edit

- mark as complete — checked

- mark as incomplete

- delete

## demos

The `demos` sub-folder provides a few helper demos to develop parts of the application.

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

### lists

Lists make up the core of the application.

`lists` and `animated_list` show the desired output with `ListView.separated` widgets. The first demo focuses on the overall layout. The second demo focuses on the animation of individual items.

`sliver_lists` and `animated_sliver:list` refactor the code to use sliver widget instead of `ListView`.

Beyond the four demos `reorderable_list` allow to sort items in a `ReorderableList` widget.

`expansion_tile` and `expansion_panel` show how to display a task and optionally the connected subtasks.
