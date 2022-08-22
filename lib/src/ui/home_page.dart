import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: S.of(context).findTutors,
              icon: Padding(
                padding: const EdgeInsetsDirectional.only(top: 8.0, end: 8, start: 8),
                child: ref.watch(currentBottomNavigatorScreenProvider) == 0
                    ? SvgPicture.asset(
                        'assets/icons/find_tutor_active'
                        '.svg',
                        width: 16,
                        height: 16,
                      )
                    : SvgPicture.asset(
                        'assets/icons/find_tutor_inactive'
                        '.svg',
                        width: 16,
                        height: 16,
                      ),
              ),
            ),
          ],
        ));
  }
}
