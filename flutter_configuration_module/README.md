### The clean architecture
![image](https://miro.medium.com/max/772/0*sfCDEb571WD-7EfP.jpg)

### DI pattern
`Dependency Injection` is a great design pattern that allows us to eliminate rigid dependencies between elements and it makes the application more flexible, easy to expand scales and maintain.
In the project we use Plugin `get_it` to implement DI and we have also defined classes so you can easily implement `DI` in the `DI layer`.
##### injection
Inject modules
##### module
     * Declare the modules used in the project.
     * All modules must extend "DIModule"
     * The registers must be set in the func provides.
     * When you want to call 1 DI just use the syntax. "getIt<My Component>()"
     * Learn more about "get_it"

### Routes
The project has predefined Named routes RouteDefine + manifest
##### 1. RouteDefine
     * All routes must extend this class.
     * When extending, you will have to override func "initRoute", here you will define your routes.
     * A feature may have multiple routes with different input arguments.
     * Make sure that the ID of each route in your project is unique.
##### 2. manifest - `lib/manifest.dart`
     *  To add a route to the project you just need to declare in the func "generateRoute". Each route will be provided with a func "build", you must call it in the func "generateRoute" of "manifest" to register.
### Network.
     * Project can use retrofit to work with the alternative network for http.
     * Retrofit is pre-installed in the "ApiModule.dart". You can customize it here
     * All interceptors are defined in the /configuration/lib/network/interceptor/* class
     * To work with Certificate, please refer to the "/configuration/lib/network/http_overrides.dart" class, with the default the project accept badCertificate

### Development environment settings.

Link tutorial: [https://www.chwe.at/2020/10/flutter-flavors/](https://www.chwe.at/2020/10/flutter-flavors/)

     * All flavor environments are installed in the "/configuration/lib/environment/buid_config.dart" class.
     * Basically we are defining 4 development environments: development, staging, preprod and release.
     * Run App

You can run the app using the commands **only ANDROID**:

```
## development: flutter run -t lib/main.dart --debug --flavor development

## staging: flutter run -t lib/main.dart --debug --flavor staging

## preprod: flutter run -t lib/main.dart --debug --flavor preprod
```

##### Build App
You can build the app using the commands

for Android

```
## development: flutter build apk -t lib/main.dart --flavor development

## staging: flutter build apk -t lib/main.dart --flavor staging

## preprod: flutter build apk -t lib/main.dart --flavor preprod
```

for IOS (updating...)

### resources
      * All resources (images, fonts, videos, ...) must be placed in the assets class
      * Before using them, please declare the path in utility class and the suffix of the class to be type_provide (image_provide.dart)


### Json parsing / serialization
This project is implementing [json_serializable](https://pub.dev/packages/json_serializable).
It use build_runner to generate files. If you make a change to these files, you need to re-run the generator using build_runner:
```
flutter pub run build_runner build
```

### Localization
Using this library to handle multi-languages. Follow this guide to understand and config languages files

### Hide Generated Files
In-order to hide generated files, navigate to Android Studio -> Preferences -> Editor -> File Types and paste the below lines under ignore files and folders section:

`*.inject.summary;*.inject.dart;*.g.dart;`
In Visual Studio Code, navigate to Preferences -> Settings and search for Files:Exclude. Add the following patterns:
```
**/*.inject.summary
**/*.inject.dart
**/*.g.dart
```