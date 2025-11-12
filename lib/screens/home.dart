import 'package:cryptoapp/data/dummy_data.dart';
import 'package:cryptoapp/screens/coin_details.dart';
import 'package:cryptoapp/theme.dart';
import 'package:cryptoapp/widgets/app_icon.dart';
import 'package:cryptoapp/widgets/listtile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Web3Theme.background,
      appBar: AppBar(
        backgroundColor: Web3Theme.background,
        leading: GradientIcon(containerSize: 10,),


        title: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            
            Text("Crypto Wallet App", style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              foreground: Paint()
              ..shader = Web3Theme.gradientPrimary.createShader(Rect.fromLTWH(0,0,200,40))
            ), ),
            Text("Web 3 Portfolio Tracker",style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey
            ),)
          ],
        ) ,



        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline_outlined,color: Colors.white,))
        ],
      ),

    
      body: Stack(
      children: [

        Positioned.fill(
          child: IgnorePointer(
            ignoring: true, 
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Web3Theme.background, 
                    Web3Theme.background, 
                    Web3Theme.card,      
                  ],

                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
        ),

      
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: true,
            child: Align(
              alignment: Alignment.topCenter, 
              child: Container(
        
                constraints: BoxConstraints(maxWidth: 1024.0),
            
                height: 384.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, 
                    end: Alignment.bottomCenter,
                    colors: [
                      Web3Theme.primary.withOpacity(0.1), 
                      Colors.transparent, 
                    ],
                  
                    stops: [0.0, 0.7],
                  ),
                ),
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: Column(
            children: [
              // SearchBar(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: CoinDummyData.coins.length,
                  itemBuilder: (context, index) {
                    final currentCoin = CoinDummyData.coins[index];

                    // return a simple, concrete widget to ensure the builder compiles and displays.
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => CoinDetails(coin: currentCoin,)));
                      },
                      child: CryptoListTile(
                        
                        name: currentCoin.name,
                        price: currentCoin.currentPrice.toString(),
                        changePercent: currentCoin.priceChangePercentage24h,
                        symbol: currentCoin.symbol.toUpperCase(),
                        imageUrl: currentCoin.imageUrl,
                                         
                      
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ),
     
      ],
    )
    );
  }
}