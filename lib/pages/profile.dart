import 'package:flutter/material.dart';
import 'package:student_online_market/pages/post_business.dart';
import 'package:student_online_market/utils/reusable_widgets.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: "Profile", 
        onSortPressed: (){}, 
        onProfilePressed: (){}, 
        onSearchPressed: (){}, 
        onCartPressed: (){}
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/static_images/user.png'),
            ),
      
            const SizedBox(height: 10),
            const Text(
              'Emmanuel Basikolo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      
            const SizedBox(height: 5),
            const Text(
              'Unima campus',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
      
            const SizedBox(height: 5),
            
            
           
      
      
      
      
      
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
      
                  },
                  child: const Text('Old Businesses'),
                ),
      
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PostBusiness()),
                    );
                  },
                  child: const Text('Create New Business'),
                ),
              ],
            ),
      
            SizedBox(height: 20),
           
            SizedBox(height: 20),
            Text(
              'About Me',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'I have big farm at home, during holidays I control the farming process so that you have best Pineapples',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Delete Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
