### Flutter version: flutter_windows_2.2.2-stable

### Git rules:
- Include 2 main branch: `master` and `dev` 
- When developers start creating a new feature, they will have to create a feature branch according to the rule:
`feature/` + *feature name* + `dev`.
- When developers complete their feature part, they will have to switch to the `dev` branch. 
Then, `pull` data from `origin`.
Next, `merge` the *feature branch* to `dev` branch
Final, `push` the dev branch to origin 

### Icons/Images:
- When you want to add an image or icon to the app, insert the image in the `assets` folder.
Then, then add the path to the corresponding file in common folder (`lib/common`)

### Presentation
- When programming the presentation, pay attention to the `*_constants.dart` file.
It includes constants of widget which has been applied to multi-screen by ScreenUtil lib

### Build runner command line
* Command generation: 
`flutter pub run build_runner build --delete-conflicting-outputs`