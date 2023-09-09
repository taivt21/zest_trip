import 'package:flutter/material.dart';

// Best viewed in result window preview size : less than or equal to 360px
// Drag the result window to resemble a mobile screen size layout

// Design : https://www.instagram.com/p/CAGwCIBjShB/

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    ),
  );
}

class OrderScreen extends StatelessWidget {
  @override
  const OrderScreen({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BGFullScreen(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 213.0),

                // title & review
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Breathtaking',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            'Antelope',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            'Canyon Tour',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                '5.0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            '472 reviews',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // botton card
                SizedBox(height: 10.0),

                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
                  height: 190.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      // overview and reviews
                      Row(
                        children: <Widget>[
                          Text(
                            'Overview',
                            style: TextStyle(
                              color: Colors.red.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Text(
                            'Reviews',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.0),

                      // price & duration
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //tag
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //tag icon
                                Icon(
                                  Icons.local_offer,
                                  color: Colors.red,
                                  size: 40,
                                ),

                                SizedBox(width: 8.0),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'PRICE',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.2),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    Text(
                                      'from',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(width: 6.0),
                                // amount

                                Text(
                                  '\$158',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //duration
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //tag icon
                                Icon(
                                  Icons.schedule,
                                  color: Colors.red,
                                  size: 40,
                                ),

                                SizedBox(width: 8.0),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'DURATION',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.2),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '3',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                          ),
                                        ),

                                        SizedBox(width: 3.0),
                                        // amount

                                        Text(
                                          'hours',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // description
                      SizedBox(height: 24.0),

                      Text(
                        'During your Antelope Canyon tour, you\'ll see how Antelope Canyon was formed - by millions of years of rain waters and wind creating an',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
        ),
        child: Text(
          'Book Now',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class BGFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1560222587-d5adc76484c3'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
