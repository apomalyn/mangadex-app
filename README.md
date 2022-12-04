# MangaDex mobile application

This is a shot for [MangaDex](mangadex.org) mobile version. Instead of having a PWA.

## Requirements

- Flutter SDK v3.3 or higher

## Getting Started

Before trying to build the application, run the following in a terminal:

```shell
flutter pub get
flutter pub run build_runner build
```

This project use flavors: `dev`, `beta` and `prod`. To run the application you need to execute the following command:

```shell
flutter run --flavor <flavor> --target lib/main_<flavor>.dart
```

For example to run the `dev` flavor:
```shell
flutter run --flavor dev --target lib/main_dev.dart
```
