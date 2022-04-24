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

### animated_list

> animate the introduction/removal of individual list items

Use `AnimatedList` as a container for list items. In the required `itemBuilder` callback specify how the items are produced in terms of widget tree — in the demo use a `SlideTransition` widget to place the list tiles from the side.

To update the list in terms of adding new items/removing old ones refer to `AnimatedList` either in a nested widget through `AnimatedList.of(context)` or elsewhere in the application with a unique key.

When updating the widget with `removeItem` or `insertItem` be sure to update the undeerlying data structure to have data and representation match.

### reorderable_list

> rearrange the order of items in a list

By default flutter adds a drag handle in the for of an icon. Replace the visual wrapping individual list items in a `ReorderableDragStartListener` widget. It is important to specify the `index` and have the value match the argument passed to the key of the wrapping container.

```dart
key: Key('${_items.indexOf(item)}'),

// ReorderableDragStartListener
index: _items.indexOf(item),
```

In the required `onReorder` callback update the underlying data structure so that the position of the items is effectively updated.

Use `proxyDecorator` to specify the appearance of the item as it is being dragged.

### expansion_tile

> show a task in title and optional subtasks

Use `ExpansionTile` to show the title of a task and toggle the visibility of possible subtasks.

In the instance there are no subtasks use a regular `ListTile` widget. The two types of tiles can coexist in the wrapping `ListView` widget.

Use `ListView.separated` to produce the tiles and separate successive tiles with whitespace.

_Update:_ while `ExpansionTile` reacts to any click on the visible header it is possible to use `GestureDetector` on the nested elements to prevent the expansion.

### expansion_panel

> show a task in title and optional subtasks

As an alternative to [_expansion_tile_](#expansiontile) use `ExpansionPanel` to conditionally show subtasks.

Advantage: ability to expand/hide the content by pressing only the handle at the end of the section.

Disadvantages: strict widget structure — you are forced to include instances of `ExpansionPanel` in an `ExpansionPanelList` widget. Default styling — it is difficult to change the visual in terms of color, spacing, obligatory handles. Inability to effectively display tasks without subtasks.

### lists

> design the lists and list items shown in the home screen

The application shows tasks in two lists, depending on whether or not the individual task as been marked as completed.

In the first list use `ListView.separated` and a list of `ListTile` widgets.

In the second list, however, wrap the same construct in an `ExpansionTile` widget. The goal is to show a string of text with the number of completed tasks and collapse/expand the associated list.

A few specificities for the second list:

- make the list stateful to rotate the custom icon as the tile is collapsed/expanded

- add an empty `trailing` field to replace the default visual, the arrow icon provided by flutter
