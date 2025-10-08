import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

/// Reusable Chat List Widget (MediaQuery-based Responsive Version)
class KChatList extends StatelessWidget {
  final List<Map<String, dynamic>> conversations;
  final Function(Map<String, dynamic>)? onItemTap;

  const KChatList({
    super.key,
    required this.conversations,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.secondaryColor,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: conversations.length,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => Divider(
          height: height * 0.001,
          thickness: height * 0.001,
          color: const Color(0xFFF1F1F1),
        ),
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return _buildChatItem(context, conversation);
        },
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, Map<String, dynamic> conversation) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final String name = conversation['name'] ?? '';
    final String email = conversation['email'] ?? '';
    final String subject = conversation['subject'] ?? '';
    final String? message = conversation['message'];
    final String time = conversation['time'] ?? '';
    final String? avatarUrl = conversation['avatarUrl'];

    return InkWell(
      onTap: onItemTap != null ? () => onItemTap!(conversation) : null,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: width * 0.06,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl == null || avatarUrl.isEmpty
                  ? Icon(Icons.person, size: width * 0.06, color: Colors.grey.shade600)
                  : null,
            ),
            SizedBox(width: width * 0.03),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Time Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: KText(
                          text: name,
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.03,
                          color: Colors.black87,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      KText(
                        text: time,
                        fontWeight: FontWeight.w400,
                        fontSize: width * 0.03,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.002),

                  // Email
                  KText(
                    text: email,
                    fontWeight: FontWeight.w400,
                    fontSize: width * 0.03,
                    color: Colors.grey.shade600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: height * 0.004),

                  // Subject
                  KText(
                    text: subject,
                    fontWeight: FontWeight.w400,
                    fontSize: width * 0.03,
                    color: AppColors.greyColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Optional message preview
                  if (message != null && message.isNotEmpty) ...[
                    SizedBox(height: height * 0.002),
                    KText(
                      text: message,
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.03,
                      color: AppColors.titleColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
