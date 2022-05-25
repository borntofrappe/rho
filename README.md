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

## app

### empty_state

Instead of setting the colors for the decoration in the widget use two color values set on the context's color scheme.

Set the color scheme value in the instance of `MaterialApp` so that the value cascade throughout the entire application.
