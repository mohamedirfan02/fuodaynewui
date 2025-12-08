import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

/// Reusable Chat List Widget (MediaQuery-based Responsive Version)
class KChatList extends StatelessWidget {
  final List<Map<String, dynamic>> conversations;
  final Function(Map<String, dynamic>)? onItemTap;

  const KChatList({super.key, required this.conversations, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    // final width = size.width;
    final height = size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.secondaryHeaderColor, //AppColors.secondaryColor,
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

  Widget _buildChatItem(
    BuildContext context,
    Map<String, dynamic> conversation,
  ) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final String name = conversation['name'] ?? '';
    final String email = conversation['email'] ?? '';
    final String subject = conversation['subject'] ?? '';
    final String? message = conversation['message'];
    final String time = conversation['time'] ?? '';
    final String? avatarUrl = conversation['avatarUrl'];
    // final String? isForward = conversation['isforward'];
    final bool forwardFlag =
        conversation['isforward']?.toString().toLowerCase() == 'true';

    String _getInitials(String name) {
      if (name.trim().isEmpty) return "";
      List<String> parts = name.trim().split(" ");
      if (parts.length == 1) {
        return parts[0].substring(0, 1).toUpperCase();
      } else {
        return (parts[0].substring(0, 1) + parts[1].substring(0, 1))
            .toUpperCase();
      }
    }

    return InkWell(
      onTap: onItemTap != null ? () => onItemTap!(conversation) : null,
      child: Container(
        width: double.infinity,
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: width * 0.05,
              backgroundColor: AppColors.checkInColor.withValues(alpha: 0.1),
              backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl == null || avatarUrl.isEmpty
                  ? KText(
                      text: _getInitials(name),
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.035,
                      color: AppColors.checkInColor,
                    )
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
                      KText(
                        text: name,
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.03, //
                        //color: Colors.black87,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: KText(
                          text: "•${email}",
                          fontWeight: FontWeight.w400,
                          fontSize: width * 0.03,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.002),

                  // SizedBox(height: height * 0.004),

                  // Subject
                  Row(
                    children: [
                      KText(
                        text: "Sub:",
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.03,
                      ),
                      Expanded(
                        child: KText(
                          text: subject,
                          fontWeight: FontWeight.w400,
                          fontSize: width * 0.03,
                          //color: theme.textTheme.bodyLarge?.color,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Optional message preview
                  if (message != null && message.isNotEmpty) ...[
                    SizedBox(height: height * 0.002),
                    Row(
                      children: [
                        if (forwardFlag) ...[
                          SvgPicture.asset(
                            AppAssetsConstants.forwardIcon,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              theme.textTheme.headlineLarge?.color ??
                                  Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: width * 0.015),
                        ],
                        Expanded(
                          child: KText(
                            text: message,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.03,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        KText(
                          text: time,
                          fontWeight: FontWeight.w400,
                          fontSize: width * 0.03,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ],
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
