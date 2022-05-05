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

It is necessary to import the `dart:ui` library to use `ImageFilter.blur`.

### text_input

> design the widget tree for the input area

Add a `Form` widget to receive user input.

Use `TextFormField` with a dedicated controller and focus node.

The controller works to extract and manage the text in the field. The focus node helps to remove focus as the text is submitted.

### dialog_input

> prompt the text input with a dialog and through the fab

Manage the text input with a mixed state strategy:

- in the parent home widget consider the controller and focus node, so that it is ultimately possible to extract the text and manage the focus around the widget, not to mention the visibility of the floating action button:

- in the child widget update a boolean flag to highlight whether the text field is empty or not

Create the dialog with the `showGeneralDialog` function, but allow to dismiss the overlay with `barrierDismissible`. Animate the overlay with a sliding transition and collapse the overlay with the `Navigator` object.

### lists

Lists make up the core of the application.

`lists` and `animated_list` show the desired output with `ListView.separated` widgets. The first demo focuses on the overall layout. The second demo focuses on the animation of individual items.

`sliver_lists` and `animated_sliver:list` refactor the code to use sliver widget instead of `ListView`.

`expansion_tile` shows how to display a task and optionally the connected subtasks. When there are no substasks use a single `ListTile` widget. When there are subtasks use `ExpansionTile` and include the subtasks in the collapse-able `children` field.

Note that in `lists` the demo makes use of an `ExpansionTile` widget to optionally show the contents of the second list. The structure is not repeated in `sliver_list` as I prefer to restructure the widget tree to have a limited number of widgets wrapped in `SliverToBoxAdapter`.

## app

In increments:

- incorporate the empty state widget. For the color use `iconColor` and `glassColor`, but make the values optional, falling back to the color scheme set on the context. Update the color scheme with a `ThemeData` widget

- in the home route add a column with a list tile, the empty state and eventually a list with the tasks

- in the list tile add the icon designed for the app. Remember to add the static file in `pubspec.yaml`

- make the status bar transparent, at least on android devices, with the `services` module

- make home into a stateful widget to manage a text controller and focus node (and soon the list)

- add a floating action button to prop the text input from dialog_input

- in the text input manage the state to know whether or not the text field is empty

- use `resizeToAvoidBottomInset` to avoid moving the content upwards as the keyboard is propped up
