import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/download_user.dart';
import 'package:stun_sync/components/atom/show_all_users.dart';
import 'package:stun_sync/components/atom/top_of_bar_admin.dart';
import 'package:stun_sync/components/atom/unit_container.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';
import 'package:stun_sync/components/atom/Background_body.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/top_of_bar.dart';
import 'package:stun_sync/components/atom/show_all_users.dart';

class HomeAdmin extends ConsumerWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color.fromARGB(255, 33, 190, 161),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 15)),
            const TopOfBarAdmin(),
            Background_body(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ContentContainer(
                      child: Container(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ref.watch(userProfile).name}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${ref.watch(userProfile).age.toString()} years old',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  )),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  ContentContainer(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleContainer(
                            title: "Peserta",
                          ),
                          ShowAllUsers(
                            database: SQLiteDB(),
                          ),
                          Downloaduser(
                            database: SQLiteDB(),
                          )
                        ],
                      ),
                    ),
                  ),

                  // const Padding(padding: EdgeInsets.only(top: 10)),
                  // const Padding(padding: EdgeInsets.only(top: 10)),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
