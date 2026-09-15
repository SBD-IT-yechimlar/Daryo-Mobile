import 'package:flutter/material.dart';

import '../../../../../core/gen/assets/assets.gen.dart';
import '../../../../widgets/ticket/ticket_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Obuna',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SubscriptionCard(
            icon: Assets.imagesDaryo.icTicketFavouriteChart.svg(),
            title: 'Biznesingizni biz bilan rivojlantiring',
            subtitle: 'Daryo.uz da reklama bering',
            buttonText: 'Reklama berish',
            buttonColor: Color(0xFF00A86B),
            borderColor: Color(0xFFE8FFEB),
            onItemClicked: (){},
          ),
          SizedBox(height: 16),
          SubscriptionCard(
            icon: Assets.imagesDaryo.icTicketCrown.svg(),
            title: 'Individual yondashuv va eksklyuziv materiallar',
            subtitle: 'Reklamalarsiz sayt mutolaasi',
            buttonText: 'Obuna Bo\'lish',
            buttonColor: Color(0xFF0A84FF),
            borderColor: Color(0xFFDFF1FF),
            price: '25 000 so\'m',
            priceSubtitle: 'bir oyiga', onItemClicked: (){
          },
          ),
        ],
      ),
    );
  }
}




