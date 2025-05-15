import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/chat/cubit/owner_chat_cubit.dart';
import 'package:boxify/screens/bottom/chat/cubit/owner_chat_state.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerChatScreen extends StatefulWidget {
  const OwnerChatScreen({super.key});

  @override
  State<OwnerChatScreen> createState() => _OwnerChatScreenState();
}

class _OwnerChatScreenState extends State<OwnerChatScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF3F4F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFFFFF),
        toolbarHeight: 80.h,
        title: Row(
          children: [
            Transform.scale(
              scale: 0.4,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(leftArrowIcon),
              ),
            ),
            SizedBox(width: 5.w),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD2D4DA)),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Image.asset(chatProfileImage, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 10.w),
            CustomText(
              data: owner,
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: PopupMenuButton(
              color: Colors.white,
              offset: Offset(0, 50),
              itemBuilder:
                  (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(width: 10.w),
                          CustomText(
                            data: clearChat,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.block),
                          SizedBox(width: 10.w),
                          CustomText(
                            data: blockUser,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<OwnerChatCubit, OwnerChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 40.h,),
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                state.isSender = (index % 2 == 0);
                return Align(
                  alignment:
                      state.isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 15.h,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 20.w,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color:
                          state.isSender
                              ? Color(0xFF0E7AFF)
                              : Color(0xFFE2E4E9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(state.isSender ? 20.r : 0),
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(state.isSender ? 0 : 20.r),
                      ),
                    ),
                    child: CustomText(
                      data: state.messages[index],
                      fontSize: 15.sp,
                      color: state.isSender ? Colors.white : null,
                    ),
                  ),
                );
              },
            );
          } else if (state is ChatError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox();
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Container(
            height: 120.h,
            color: Color(0xFFFFFFFF),
            child: Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 25.w),
              child: Stack(
                children: [
                  TextField(
                    controller: context.read<OwnerChatCubit>().messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF3F4F8),
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Color(0xFF636363),
                        fontSize: 15.sp,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Color(0XFFD2D4DA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Color(0XFFD2D4DA)),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.only(top: 25.h, left: 20.w),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => context.read<OwnerChatCubit>().messageController.clear(),
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(6.r),
                          color: Color(0xFF0E7AFF),
                        ),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
