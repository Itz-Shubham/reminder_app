# Reminder App - Flutter
![Cover](/screenshots/cover.png)
---

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
4. [Usage](#usage)
    - [Homepage](#homepage)
    - [Edit or Add Task](#edit-or-add-task)
5. [Local Notifications](#local-notifications)
6. [Hive Data Persistence](#hive-data-persistence)
7. [Build Process](#build-process)
8. [Contributing](#contributing)
9. [License](#license)

## Introduction

Welcome to the Flutter Task Reminder App! This application is designed to help users manage their daily tasks by providing timely reminders through local notifications.

## Features

- Add and manage tasks for different times of the day.
- Receive local notifications for task reminders.
- Homepage displaying all tasks and an Edit/Add Task screen.
- Data persistence using Flutter Hive.

## Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Itz-Shubham/reminder_app.git
```

2. Navigate to the project directory:

```bash
cd reminder_app
```

3. Install dependencies:

```bash
flutter pub get
```

## Usage

### Homepage

The homepage is where all tasks are displayed. Users can quickly check their schedule for the day.

### Edit or Add Task

The Edit/Add Task screen allows users to modify existing tasks or add new ones. Users can set the task name, time, and other details.

## Local Notifications

The app uses local notifications to remind users of their tasks at the specified times. Make sure to grant the necessary permissions for notifications on your device.

## Hive Data Persistence

Hive is used for efficient data persistence. Task data is stored locally, ensuring that the user's schedule is preserved even if the app is closed or the device is restarted.

### Updating Hive Models

If there are changes to the Hive data models, run the following command to generate the necessary code:

```bash
dart run build_runner build
```

## Build Process

To build the Flutter app, use the following command:

```bash
flutter build apk
```

This will generate an APK file that can be installed on Android devices.

## Contributing

Feel free to contribute to the project by opening issues or submitting pull requests. Make sure to follow the established coding guidelines and conventions.

## License

This project is licensed under the [MIT License](LICENSE).

---