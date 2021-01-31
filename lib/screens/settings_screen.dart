import 'package:flutter/material.dart';
import '../widgets/my_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '\settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (ctx, _) => [
          MyAppBar(
            isSettings: true,
          )
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              title: Text(
                'Shikhar Agarwal',
                style: Theme.of(context).textTheme.headline3,
              ),
              subtitle: Text('Name'),
            ),
            ListTile(
              title: Text(
                '18',
                style: Theme.of(context).textTheme.headline3,
              ),
              subtitle: Text('Age'),
            ),
            ListTile(
              title: Text(
                'MIT , Manipal',
                style: Theme.of(context).textTheme.headline3,
              ),
              subtitle: Text('College'),
            ),
            ListTile(
              title: Text(
                'B.Tech in Mechatronics Engineering',
                style: Theme.of(context).textTheme.headline3,
              ),
              subtitle: Text('Course'),
            ),
          ],
        ),
      ),
    );
  }
}
