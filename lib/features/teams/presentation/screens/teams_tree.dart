import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:graphview/GraphView.dart';

class TeamsTree extends StatefulWidget {
  const TeamsTree({super.key});

  @override
  State<TeamsTree> createState() => _TeamsTreeState();
}

class _TeamsTreeState extends State<TeamsTree> {
  final Graph graph = Graph();
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();

    // Create nodes with unique IDs
    var ceo = Node.Id("ceo");
    var hr = Node.Id("hr");
    var ishManager = Node.Id("ishManager");
    var itManager = Node.Id("itManager");

    var revathi = Node.Id("revathi");
    var sriVidhya = Node.Id("sriVidhya");

    var vimal = Node.Id("vimal");
    var gino = Node.Id("gino");
    var irfan = Node.Id("irfan");
    var karkavel = Node.Id("karkavel");

    // Add nodes to graph
    graph.addNode(ceo);
    graph.addNode(hr);
    graph.addNode(ishManager);
    graph.addNode(itManager);
    graph.addNode(revathi);
    graph.addNode(sriVidhya);
    graph.addNode(vimal);
    graph.addNode(gino);
    graph.addNode(irfan);
    graph.addNode(karkavel);

    // Add edges to create hierarchy
    graph.addEdge(ceo, hr);
    graph.addEdge(ceo, ishManager);
    graph.addEdge(ceo, itManager);

    graph.addEdge(ishManager, revathi);
    graph.addEdge(ishManager, sriVidhya);

    graph.addEdge(itManager, gino);
    graph.addEdge(itManager, vimal);
    graph.addEdge(itManager, irfan);
    graph.addEdge(itManager, karkavel);

    // Graph layout settings
    builder
      ..siblingSeparation = 25
      ..levelSeparation = 60
      ..subtreeSeparation = 30
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  Widget _buildEmployeeCard(String name, String role, String imageUrl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.subTitleColor, width: 1.w),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        width: 120.w, // Fixed width for consistency
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Person Avatar
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 25.r),

            SizedBox(height: 6.h),

            // Person Name
            KText(
              text: name,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: AppColors.titleColor,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 3.h),

            // Person Role
            KText(
              text: role,
              fontWeight: FontWeight.w600,
              fontSize: 8.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          KVerticalSpacer(height: 20.h),

          // Graph View Container
          Container(
            height: 600.h, // Set appropriate height
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(100.w),
              minScale: 0.3,
              maxScale: 3.0,
              child: GraphView(
                graph: graph,
                algorithm: BuchheimWalkerAlgorithm(
                  builder,
                  TreeEdgeRenderer(builder),
                ),
                builder: (Node node) {
                  // Map node IDs to employee information
                  switch (node.key?.value) {
                    case "ceo":
                      return _buildEmployeeCard(
                        "Krishnakanth ST",
                        "FOUNDER & CEO",
                        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww",
                      );
                    case "hr":
                      return _buildEmployeeCard(
                        "Aysha Begam",
                        "hr",
                        "https://images.unsplash.com/photo-1494790108755-2616b9e6d4cc?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "ishManager":
                      return _buildEmployeeCard(
                        "Ishwarya K",
                        "ASSISTANT MANAGER - CC & BANKING",
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "itManager":
                      return _buildEmployeeCard(
                        "Saravanan S",
                        "INFORMATION TECHNOLOGY",
                        "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "revathi":
                      return _buildEmployeeCard(
                        "Revathi .",
                        "SENIOR EXECUTIVE",
                        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "sriVidhya":
                      return _buildEmployeeCard(
                        "Sri Vidhya",
                        "ASSISTANT MANAGER AMAZON",
                        "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "vimal":
                      return _buildEmployeeCard(
                        "Vimal Raj L",
                        "AI DEVELOPER",
                        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "gino":
                      return _buildEmployeeCard(
                        "Gino B",
                        "PROJECT MANAGER-IT",
                        "https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "irfan":
                      return _buildEmployeeCard(
                        "Mohamed Irfan",
                        "MOBILE APP DEVELOPER",
                        "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    case "karkavel":
                      return _buildEmployeeCard(
                        "Karkavel Raja",
                        "AI DEVELOPER",
                        "https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0",
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
