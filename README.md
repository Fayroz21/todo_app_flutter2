# todo_pp

A new Flutter project.
This app lets users create categories of its own and for each category he can
assign a set of to do lists. Users can update and delete certain categories they want. They can view all their tasks in the home page or tasks of each category from the drawer. Also, they can update, delete tasks and check if any task was done.

Categories Model: Id, Name and Description.
Todo tasks Model: Id, Title, Details, Datea, Category, IsDone.

Technologies Used:
State management was getx.
Database I used sqflite, path provider.
Flutter slidable : to slide cards for update and delete.
Flutter screen util for different sizes.
ShowDatePicker
ShowDialog

Notes:
Update and save of the tasks are the same screen but I control their function based on a boolean variable.
When users add or delete categories the update appears in the homepage drawer, and drop down box of tasks.
Adding show date picker in task date text.
Status of finish saved in database. So, it appears everywhere.
There are custom widgets used in many different places.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
