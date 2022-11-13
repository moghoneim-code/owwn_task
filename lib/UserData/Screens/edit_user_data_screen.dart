import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/MainPage/Models/user_model.dart';
import 'package:owwn_coding_challenge/Network/view_state.dart';
import 'package:owwn_coding_challenge/Shared/widgets/provider_listener.dart';
import 'package:owwn_coding_challenge/UserData/Providers/user_provider.dart';
import 'package:owwn_coding_challenge/UserData/Widgets/user_header.dart';
import 'package:provider/provider.dart';

class EditDataScreen extends StatefulWidget {
  const EditDataScreen({
    super.key,
  });

  @override
  State<EditDataScreen> createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  bool isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  /// initializes the text controllers
  void _init() {
    _nameController.text =
        Provider.of<UserProvider>(context, listen: false).selectedUser!.name;
    _emailController.text =
        Provider.of<UserProvider>(context, listen: false).selectedUser!.id;
  }

  ///disposing the text controllers
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  bool isNameFocused = false;

  @override
  void initState() {
    _init();
    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) {
        setState(() {
          isNameFocused = true;
        });
      } else {
        setState(() {
          isNameFocused = false;
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ///request focus on the name field
    _nameFocusNode.requestFocus();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    /// Listen to the provider to perform actions when the state changes
    return ProviderListener<UserProvider>(
      listener: (context, p) {
        if (p.updateUserState == ViewState.loaded) {
          log('User updated');
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },

      /// Listen to the provider to get the selected user
      child: Consumer<UserProvider>(
        builder: (context, p, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            backgroundColor: KColors.primaryColor,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _floatingButton(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const UserHeader(
                    active: false,
                  ),

                  /// Name field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: _nameController,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color:
                                isNameFocused ? Colors.white : Colors.white60,
                            fontSize: 25,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            isEditing = true;
                          });
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isNameFocused ? Colors.white : Colors.white60,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  /// Email field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          setState(() {
                            isEditing = true;
                          });
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color:
                                !isNameFocused ? Colors.white : Colors.white60,
                            fontSize: 18,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !isNameFocused ? Colors.white : Colors.white60,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// floating button to save the changes
  Widget _floatingButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2E22F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          final UserProvider p =
              Provider.of<UserProvider>(context, listen: false);
          final user = UserModel(
            id: _emailController.text,
            name: _nameController.text,
            email: p.selectedUser!.email,
            gender: p.selectedUser!.gender,
            status: p.selectedUser!.status,
            partnerId: p.selectedUser!.partnerId,
            createdAt: p.selectedUser!.createdAt,
            statistics: p.selectedUser!.statistics,
          );
          p.updateUser(user);
        },
        child: const Text('save', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
