import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/logo_container.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/database/models/logo_list.dart';

class RecommendationTab extends StatelessWidget {
  const RecommendationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 10),
            child: const TitleContainer(title: 'Recommendation'),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Row(
            children: [
              LogoContainer(logo: LogoList.exercise, text: 'Exercise'),
              Padding(padding: EdgeInsets.only(right: 30)),
              LogoContainer(logo: LogoList.food, text: 'Food'),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10))
        ],
      ),
    );
  }
}
