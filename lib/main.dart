import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_light_dark_automatic/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Theme Example',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primaryColor: Colors.blue,
              hintColor: Colors.blue,
              buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
              textTheme: TextTheme(
                bodyText2: TextStyle(color: Colors.black),
                // Add more text styles as needed
              ),
              appBarTheme: AppBarTheme(
                color: Colors.blue,
                // Customize app bar attributes if needed
              ),
              scaffoldBackgroundColor: Colors.white,
              // Customize other theme attributes if needed
            ),
            darkTheme: ThemeData(
                buttonTheme: ButtonThemeData(
                  buttonColor: Colors.red,
                ),
                textTheme: TextTheme(
                  bodyText2: TextStyle(color: Colors.blue),
                  subtitle1: TextStyle(color: Colors.white),
                ),
                drawerTheme: DrawerThemeData(backgroundColor: Colors.grey),
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.blue),
                    color: Colors.black,
                    titleTextStyle: TextStyle(color: Colors.blue, fontSize: 20)
                    // Customize app bar attributes if needed
                    ),
                scaffoldBackgroundColor: Colors.black,
                // Customize other theme attributes if needed
                dialogTheme: DialogTheme(backgroundColor: Colors.grey)),
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Example'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Mode'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ThemeDialog(themeProvider: themeProvider);
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Theme Mode:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            RadioListTile<ThemeModeOptions>(
              title: Text('Light'),
              value: ThemeModeOptions.Light,
              groupValue: themeProvider.selectedMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
              },
            ),
            RadioListTile<ThemeModeOptions>(
              title: Text(
                'Dark',
              ),
              value: ThemeModeOptions.Dark,
              groupValue: themeProvider.selectedMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
              },
            ),
            RadioListTile<ThemeModeOptions>(
              title: Text('System'),
              value: ThemeModeOptions.System,
              groupValue: themeProvider.selectedMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeDialog extends StatelessWidget {
  final ThemeProvider themeProvider;

  ThemeDialog({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Choisissez un mode'),
      children: [
        RadioListTile<ThemeModeOptions>(
          title: Text('Mode Lumière'),
          value: ThemeModeOptions.Light,
          groupValue: themeProvider.selectedMode,
          onChanged: (value) {
            themeProvider.setThemeMode(value!);
            Navigator.pop(context);
          },
        ),
        RadioListTile<ThemeModeOptions>(
          title: Text('Mode Sombre'),
          value: ThemeModeOptions.Dark,
          groupValue: themeProvider.selectedMode,
          onChanged: (value) {
            themeProvider.setThemeMode(value!);
            Navigator.pop(context);
          },
        ),
        RadioListTile<ThemeModeOptions>(
          title: Text('Mode Automatique'),
          value: ThemeModeOptions.System,
          groupValue: themeProvider.selectedMode,
          onChanged: (value) {
            themeProvider.setThemeMode(value!);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
