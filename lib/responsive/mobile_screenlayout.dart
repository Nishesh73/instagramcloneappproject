import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/globalvariable.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }



 
 int _page=0;
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (int page){
          setState(() {
            _page=page;
            
          });
          


        },
        

        children: homeScreens,
       

      ),

      bottomNavigationBar: CupertinoTabBar(
        

        onTap: (int page){

          pageController.jumpToPage(page);
        },
        backgroundColor: mobileBackgroundColor,
        
        
        items: [
          
        BottomNavigationBarItem(icon: Icon(Icons.home,
        color:_page==0?primaryColor: secondaryColor,),label: "home",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.search,color:_page==1?primaryColor: secondaryColor),label: "",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle,color:_page==2?primaryColor: secondaryColor),label: "",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.favorite,color:_page==3?primaryColor: secondaryColor),label: "",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.person,color:_page==4?primaryColor: secondaryColor),label: "",backgroundColor: primaryColor),

      ]),
    );
  }
}