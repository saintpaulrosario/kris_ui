// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mariel/feature/auth/logic/account/account_bloc.dart';
// import 'package:mariel/feature/kodofola/model/script.dart';
// import 'package:mariel/feature/kodofola/presentation/app_drop_down.dart';
// import 'package:mariel/feature/kodofola/presentation/script_app_bar.dart';
// import 'package:mariel/feature/kodofola/presentation/widget/dialect_app_bar.dart';
// import 'package:mariel/feature/profile/bloc/account_profile/account_profile_bloc.dart';

// import 'common/widget/avatar_widget.dart';
// import 'feature/kodofola/presentation/language_app_bar.dart';

// class KulkulkanAccountDrawer extends StatelessWidget {
//   const KulkulkanAccountDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: BlocBuilder<AccountBloc, AccountState>(
//         builder: (context, accountState) {
//           return BlocBuilder<AccountProfileBloc, AccountProfileState>(
//             builder: (context, profileState) {
//               return ListView(
//                 children: [
//                   UserAccountsDrawerHeader(
//                     decoration: const BoxDecoration(color: Colors.blue),
//                     accountName: Text(profileState.profile.name),
//                     accountEmail: Text(profileState.profile.email),
//                     onDetailsPressed: () {
//                       // Optionally expand details
//                     },
//                     currentAccountPicture: GestureDetector(
//                       onTap: () {
//                         // Optionally show profile or avatar picker
//                       },
//                       child: Avatar(alias: profileState.profile.alias),
//                     ),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.person),
//                     title: const Text('Profile'),
//                     onTap: () {
//                       Navigator.pop(context);
//                       // TODO: Navigate to profile page
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.settings),
//                     title: const Text('Settings'),
//                     onTap: () {
//                       Navigator.pop(context);
//                       // TODO: Navigate to settings page
//                     },
//                   ),
//                   if (accountState.authenticated)
//                     ListTile(
//                       leading: const Icon(Icons.logout),
//                       title: const Text('Logout'),
//                       onTap: () {
//                         //context.read<AccountBloc>().add(AccountLoggedOut());
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ListTile(
//                     leading: const Icon(Icons.language_sharp),
//                     title: Text("scripts"),
//                     subtitle: ScriptAppBar(),
//                   ),

//                   ListTile(
//                     leading: const Icon(Icons.wordpress_outlined),
//                     title: Text("Languages"),
//                     subtitle: LanguageAppBar(),
//                   ),

//                   ListTile(
//                     leading: const Icon(Icons.noise_aware),
//                     title: Text("dialects"),
//                     subtitle: DialectAppBar(),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
