// import 'package:flutter/material.dart';
// import '../../../common/widgets/app_textfield.dart';
//
// class AuthForm extends StatefulWidget {
//   const AuthForm({
//     Key? key,
//     required this.value,
//     required this.emailKey,
//     required this.passwordKey,
//     required this.userEmail,
//     required this.userPassword,
//     required this.isChecked,
//     required this.isButtonActive,
//   }) : super(key: key);
//
//   final bool value;
//   final emailKey;
//   final passwordKey;
//   final String userEmail;
//   final String userPassword;
//   final bool isChecked;
//   final bool isButtonActive;
//
//   @override
//   State<AuthForm> createState() => _AuthFormState();
// }
//
// class _AuthFormState extends State<AuthForm> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Card(
//           elevation: 25,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(13),
//           ),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 _buildForm(widget.value, widget.emailKey, widget.passwordKey,
//                     widget.userEmail, widget.userPassword),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: CheckboxListTile(
//                     value: widget.value,
//                     onChanged: (value) {
//                       setState(() {
//                         this.value = value!;
//                         isChecked = value;
//                         isButtonActive = value;
//                       });
//                     },
//                     title: const Text(
//                       'I consent to the processing of data for the marketing purposes',
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     controlAffinity: ListTileControlAffinity.leading,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Column _buildForm(value, emailKey, passwordKey, email, password) {
//   return Column(
//     children: [
//       Form(
//         key: emailKey,
//         child: Field(
//           hintText: 'Email',
//           icon: const Icon(Icons.account_circle),
//           enabled: value,
//           inputType: TextInputType.emailAddress,
//           obscure: false,
//           onSaved: (val) {
//             email = val;
//           },
//           validator: (input) {
//             if (input == null || !input.contains('@')) {
//               return 'Please enter a valid email address.';
//             }
//             return null;
//           },
//         ),
//       ),
//       Form(
//         key: passwordKey,
//         child: Field(
//           hintText: 'Password',
//           icon: const Icon(Icons.lock),
//           enabled: value,
//           inputType: TextInputType.visiblePassword,
//           obscure: true,
//           onSaved: (val) {
//             password = val;
//           },
//           validator: (input) {
//             if (input == null || input.length < 7) {
//               return 'Password must be at least 7 characters long';
//             }
//             return null;
//           },
//         ),
//       ),
//     ],
//   );
// }
