# Before you build

Prepare

- `Google API Key` - must have for google maps.
- `Google_services.json` - must have for firebase sdk.

Set environment variable `GOOGLE_MAP_API_KEY` to `Google API Key`.

Make sure that **you have running** back-end.

## :bulb: Create configuration
Application uses configuration file. For now implementation has two different environments - *dev* and *production*. 

Confiruguration files reside in *assets/config* as 

- dev.json - development configuration
- prod.json - production configuration

Create **mandatory** and **default** configuration file `dev.json` with following content:

```json
{
    "apiUrl": "<API_URL>"
}
```

## :hammer_and_wrench: Run and build

Update packages
```cli
flutter pub get
```

Run builder (generating Freezed files)
```
# If you are on windows use prepared script
./scripts/run_builder.ps1

# If on *NIX system
flutter pub run build_runner watch --delete-conflicting-outputs
```

And run as release build (but with dev configuration)
```cli
flutter run --release
```

If you want run release environment - create `prod.json` and run
```cli
flutter run -t lib/main_prod.dart  --release
```

## :package: Note about used packages

Two awesome packages. Without them it would be harder. 

- [flutter_bloc](https://github.com/felangel/bloc) - BLoC pattern
- [freezed](https://github.com/rrousselGit/freezed) - Heavily used for representing BLoC's events and states.

...and many more. Just open `pubspec.yaml`.