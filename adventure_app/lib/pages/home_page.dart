import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/widgets/app_large_text.dart';
import 'package:travel_app/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  var images={
    "welcome_third.jpg":"Balloning",
    "hiking.png":"Hiking",
    "kayaking.png":"Kayaking",
    "hiking2.png":"Hiking",
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController=TabController(length:3, vsync: this);

    return Scaffold(
      body: BlocBuilder<AppCubits,CubitStates>(
        builder: (context,state){
          if(state is LoadedState){
            var info = state.places;
            return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //menu text
          Container(
            padding: EdgeInsets.only(top:70 ,left: 20),
            child: Row(
              children: [
                Icon(Icons.menu,size:30,color: Colors.black54,),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(right:20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height:30),
          //discover text
          Container(
            margin: EdgeInsets.only(left: 20),
            child: AppLargeText(text: "Discover")),
          SizedBox(height: 20,),
          //tabbar
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: EdgeInsets.only(left: 0,right: 40),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                tabs: [
                  Tab(text: "Places"),
                  Tab(text:"Inspiration"),
                  Tab(text: "Emotions",)
                ],
              ),
            ),
          ),
          Container( 
            padding: EdgeInsets.only(left: 20),      
            height: 300,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: info.length,
                  itemBuilder: (BuildContext context, int index) { 
                    return GestureDetector(
                      onTap: (){
                        BlocProvider.of<AppCubits>(context).detailPage(info[index]);
                      },
                      child: Container(
                      margin: EdgeInsets.only(right: 15, top: 10),
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "http://mark.bslmeiyu.com/uploads/"+info[index].img
                          )
                        )
                      ),
                                        ),
                    );
                  },
                ),

                Text("There"),
                Text("Bye"),
              ],
            ),
          ),
          SizedBox(height:30 ,),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppLargeText(text: "Explore more",size: 22,),
                AppText(text: "See all",color: AppColors.textColor1,)
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 120,
            width: double.maxFinite,
            margin: EdgeInsets.only(left: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (_,index){
              return Container(
                margin: const EdgeInsets.only(right: 30),
                child: Column(
                  children: [
                    Container(
                      //margin: EdgeInsets.only(right: 50),
                      width:80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/image/"+images.keys.elementAt(index)
                          )
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: AppText(text: images.values.elementAt(index),color: AppColors.textColor2,) ,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      );
          }else{
            return Container();
          }
        },
      )
    );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color:color,radius:radius);
  }

}

class _CirclePainter extends BoxPainter{

  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    Paint _paint=Paint();
    _paint.color=color;
    _paint.isAntiAlias=true;

    final Offset circleOffset=Offset(configuration.size!.width/2 -radius/2, configuration.size!.height);

    canvas.drawCircle(offset+circleOffset, radius, _paint);


  }
    
}