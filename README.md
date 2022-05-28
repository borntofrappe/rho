# rho

A good looking task-taking app.

## figma

In the `figma` sub-folder you find a few images describing the overall concept behind the application, both in terms of design and features.

At the time of writing I plan to create a task-taking app which allows to add, check, edit and delete tasks.

## demos

In the `demos` sub-folder you find helper scripts I create to distill parts of the larger application.

### empty_state

With `EmptyState` I create the visual displayed by default in the home screen, when there are no tasks to-be-listed. Refer to `01 - home.png` for the general idea.

The decoration is made up of three overlapping elements, two semi-transparent boxes and one solid icon. Use `BackdropFilter` to blur the background of the topmost box to create the glass-like effect.

Below the decoration include a text widget.

I created the widget to receive optional arguments and customize its appearance. In the current design you can change the color of the decoration, the icon displayed on top of the glass and the text widget.

Note that it is necessary to import `dart:ui` library to use `ImageFilter.blur`.

### general_dialog

In the application the idea is to create a new task through the floating action button. Tap said button to show a text input in the bottom section of the screen, compose the task and confirm the text. With the demo I focus on the way the text input is supposed to appear, in the form of a general dialog.

Use `showGeneralDialog` to generate the visual above the page. Past the required fields, `context` and `pageBuilder`, specify how the dialog appears, with a slide transition and from the bottom of the screen.

In `pageBuilder` describe the appearance of the dialog with a column with two children, one to show the text-input-to-be and one to dismiss the dialog.

I chose to make the widget stateful to also remove the floating action button as the dialog is propped up. Flutter automatically transitions the button when setting the `floatingActionButton` field to `null`.

### text_input

In the dialog the idea is to accept text input to create a task.

With `TextInput` manage the state of a `TextFormField` widget with a controller and a focus node.

The widget itself precedes a button to equally receive the input with a button press. Wrap both in a `Column` and `Form` widget, so clarify the purpose of the component.

With the controller retrieve the string of text and clear the field.

With the focus node manage remove focus as you ultimately submit the text.

With a boolean variable finally control when the input field is empty, so to change the appearance of the associated button.

### list_tile

Each task is displayed with a `ListTile` with two main sections, a leading icon and the title of the task itself.

Define a `Task` class to manage the logic of each task item. At the time of writing the task has only two fields for its label and complete status.

Define a hard-coded list of tasks to test out the design of the tile.

In the demo I use a `ListView.separated` widget but I am in the process of researching alternative solutions considering sliver lists specifically.

Most importantly for the functionality of the application the list tile needs to accommodate different gestures:

- a tap on the leading icon should result in the task being marked as complete or unmark as unfinished

- a tap on the tile should allow to edit the tile through the same dialog discussed in a previous demo

- a long press on the tile should allow to select the tile, with the ultimate goal of deleting the piece

### lists

The application differentiates tasks first showing unfinished tasks and then, optionally, completed ones. The demo creates a stateless widget `Tasks` which receives a list of tasks and uses `ListView.separated` to display the individual tiles. It is necessary to set `shrinkWrap` to `true` to have Flutter evaluate the size of the widgets, which might create [issues](https://api.flutter.dev/flutter/widgets/ScrollView/shrinkWrap.html) as the lists grow in size and animations.

To optionally show the completed variant use an `ExpansionTile` widget with a custom icon in place of the one added in the `trailing` field. Remove this default setting the field to an empty widget like `ExcludeSemantics`.

### sliver_lists

As prefaced in the lists demo `shrinkWrap` is potentially problematic as the application computes the size of the entire widget to allocate the necessary space. Slivers promise to fix the issue with dedicated widgets: `CustomScrollView`, `SliverList` and `SliverChildBuilderDelegate`.

To add space between successive list items I follow the example provided in the accessibility section of [SliverChildBuilderDelegate](https://api.flutter.dev/flutter/widgets/SliverChildBuilderDelegate-class.html): add twice the number of items, include a `SizedBox` for every other item, update the index to provide the correct semantics.

Past the sliver widgets devoted to the list the demo introduces `SliverPadding` and `SliverToBoxAdapter`, since `CustomScrollView` requires a list of slivers instead of widgets.

`SliverToBoxAdapter` is used to incorporate a list tile to replace the functionality of `ExpansionTile`. Tap on the tile to toggle the visibility of the sliver list devoted to completed tasks.

In the process I lost the transition built-in the expansion widget, and I could add a small effect with `SliverAnimatedOpacity`, but the functionality might become redundant considering `AnimatedSliverList`.

## app

### empty_state

Instead of setting the colors for the decoration in the widget use two color values set on the context's color scheme.

Set the color scheme value in the instance of `MaterialApp` so that the value cascade throughout the entire application.

### general_dialog

Outside of using the colors set through the theme widget set `resizeToAvoidBottomInset` to `false` so that the widgets included in the `body` of the scaffold widget do not translate as the keyboard appears.

### text_input

In the context of the dialog generated through the floating action button it is possible to use the focus node and to condition the floating action button itself.

Following this option it is also possible to make the general dialog dismissible. Note that `barrierLabel` becomes necessary to allow the dismissible feature.

It would be possible to make `TextInput` a stateless widget, since you ultimately manage the associated logic from `Home`. Ultimately I decided to maintain the stateful nature so that the widget manages the logic associated with the button, updating `_isEmpty` in the `onChanged` field. The controller and focus node are themselves lifted up to the parent widget.
