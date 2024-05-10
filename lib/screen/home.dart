import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/Background_body.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/top_of_bar.dart';

String nama = "ihza soerya";
double height = 165;
double weight = 50;
double bmi = 18.4;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF22577A),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopOfBar(),
            Background_body(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentContainer(
                      child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$nama',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Age: 30',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '7 days left',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'until next check',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  ContentContainer(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleContainer(
                            title: "Recomendation",
                          ),
                          Text(
                              'Ensure they receive a balanced diet rich in protein, calcium, vitamin D, and provide physical stimulation through exercise or activities that stimulate bone and muscle growth.'),
                        ],
                      ),
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleContainer(
                          title: "Height",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [ValueContainer(value: "$height")],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleContainer(
                          title: "Weight",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [ValueContainer(value: "$weight")],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleContainer(
                          title: "BMI",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [ValueContainer(value: "$bmi")],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
