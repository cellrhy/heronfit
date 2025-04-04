import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'edit_profile.dart'; // Import the EditProfileWidget
import '../booking/my_bookings.dart'; // Import the MyBookingsWidget
import '../workout/workout_history_widget.dart'; // Import the WorkoutHistoryWidget
import 'contactUs_screen.dart'; // Import the ContactUsWidget
import 'privacyPolicy_screen.dart'; // Import the PrivacyPolicyWidget
import 'termsOfUse_screen.dart'; // Import the TermsOfUseWidget
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: 4,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: Scaffold(
                                              appBar: AppBar(),
                                              body: Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: 'https://images.unsplash.com/photo-1531123414780-f74242c2b052?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDV8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl: 'https://images.unsplash.com/photo-1531123414780-f74242c2b052?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDV8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Text(
                                          'John Doe',
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Goal | ',
                                              style: Theme.of(context).textTheme.labelMedium,
                                            ),
                                            TextSpan(
                                              text: 'Lose Weight',
                                              style: const TextStyle(),
                                            ),
                                          ],
                                          style: Theme.of(context).textTheme.labelMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EditProfileWidget(),
                                  ),
                                );
                              },
                              child: const Text('Edit'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                foregroundColor: Colors.white, // Ensures the text color is white
                                textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(                          
                                      fontWeight: FontWeight.bold,                        
                                ), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoCard(context, '180 cm', 'Height'),
                          _buildInfoCard(context, '70 kg', 'Weight'),
                          _buildInfoCard(context, '25 yo', 'Age'),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _buildAccountSection(context),
                          _buildNotificationSection(context),
                          _buildOtherSection(context),
                          ElevatedButton.icon(
                            onPressed: () async {
                              // Handle logout
                              try {
                                await Supabase.instance.client.auth.signOut();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Logged out successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                // Navigate to login screen
                                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error logging out: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.logout, size: 24.0,),
                            label: const Text('Logout'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12), //change to 12 from 8
                              textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 48), //added
                            ),
                          ),
                        ].map((widget) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: widget,
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String value, String label) {
    return Expanded(
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          /*boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 2),
            ),
          ],*/
          //borderRadius: BorderRadius.circular(8),//
        ),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Theme.of(context).colorScheme.background,
          elevation: 0,
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),*/
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(),
                      ),
                    ],
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return _buildSection(
      context,
      'Account',
      [
        _buildSectionItem(context, Icons.person, 'Edit Profile', () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileWidget(),
            ),
          );
        }),
        _buildSectionItem(context, Icons.book, 'My Bookings', () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyBookingsWidget(),
            ),
          );
        }),
        _buildSectionItem(context, Icons.history, 'Workout History', () {
          Navigator.pushNamed(context, '/workoutHistory');
        }),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/workoutHistory');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'View Workout History',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationSection(BuildContext context) {
    return _buildSection(
      context,
      'Notification',
      [
        _buildSectionItem(context, Icons.notifications, 'Pop-up Notification', () {
          // Handle notification settings
        }),
      ],
    );
  }

  Widget _buildOtherSection(BuildContext context) {
    return _buildSection(
      context,
      'Other',
      [
        _buildSectionItem(context, Icons.contact_mail, 'Contact Us', () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactUsWidget(),
          ),
        );
      }),
        _buildSectionItem(context, Icons.privacy_tip, 'Privacy Policy', () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PrivacyPolicyWidget(),
          ),
        );
      }),
         _buildSectionItem(context, Icons.info, 'Terms Of Use', () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TermsOfUseWidget(),
          ),
        );
      }),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        /*boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).shadowColor,
            offset: const Offset(0, 2),
          ),
        ],*/
        //borderRadius: BorderRadius.circular(16),//
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: item,
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: Theme.of(context).colorScheme.onSurface,
            size: 16,
          ),
        ],
      ),
    );
  }
}