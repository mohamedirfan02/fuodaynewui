import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/team_tree/presentation/provider/team_tree_provider.dart';
import 'package:fuoday/features/team_tree/domain/entities/team_tree_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

class TeamTreeScreen extends StatelessWidget {
  final int webUserId;

  const TeamTreeScreen({super.key, required this.webUserId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<TeamTreeProvider>()..fetchTeamTree(webUserId),
      child: const _TeamTreeView(),
    );
  }
}

class _TeamTreeView extends StatefulWidget {
  const _TeamTreeView({super.key});

  @override
  State<_TeamTreeView> createState() => _TeamTreeViewState();
}

class _TeamTreeViewState extends State<_TeamTreeView> {
  final Graph graph = Graph();
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    builder
      ..siblingSeparation = 25
      ..levelSeparation = 60
      ..subtreeSeparation = 30
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  Widget _buildEmployeeCard(String name, String role, String? imageUrl) {
    //App Theme Data
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:
              theme.inputDecorationTheme.focusedBorder?.borderSide.color ??
              AppColors.subTitleColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        width: 120.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
              radius: 25.r,
              child: imageUrl == null ? const Icon(Icons.person) : null,
            ),
            SizedBox(height: 6.h),
            KText(
              text: name,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color:
                  theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            KText(
              text: role,
              fontWeight: FontWeight.w500,
              fontSize: 8.sp,
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _buildHierarchicalGraph(List<TeamTreeEntity> data) {
    // Create a map for quick lookups
    Map<int, TeamTreeEntity> managerMap = {};
    Map<int, EmployeeEntity> employeeMap = {};

    for (var team in data) {
      managerMap[team.managerId] = team;
      for (var emp in team.employees) {
        employeeMap[emp.id] = emp;
      }
    }

    // Find the root manager (CEO - Krishnakanth ST with ID 31)
    final rootTeam = data.firstWhere(
      (team) => team.managerId == 31,
      orElse: () => data.first, // fallback to first if 31 not found
    );

    final rootNode = Node.Id("manager_${rootTeam.managerId}");
    graph.addNode(rootNode);

    // Add root manager's direct employees
    for (var emp in rootTeam.employees) {
      final empNode = Node.Id("emp_${emp.id}");
      graph.addNode(empNode);
      graph.addEdge(rootNode, empNode);

      // Check if this employee is also a manager
      final subTeam = data.firstWhere(
        (team) => team.managerId == emp.id,
        orElse: () =>
            TeamTreeEntity(managerId: 0, managerName: '', employees: []),
      );

      if (subTeam.managerId != 0 && subTeam.employees.isNotEmpty) {
        // This employee is also a manager, add their team
        _addSubTeam(empNode, subTeam, data);
      }
    }
  }

  void _addSubTeam(
    Node managerNode,
    TeamTreeEntity team,
    List<TeamTreeEntity> allData,
  ) {
    for (var emp in team.employees) {
      final empNode = Node.Id("emp_${emp.id}");
      graph.addNode(empNode);
      graph.addEdge(managerNode, empNode);

      // Check if this employee is also a manager
      final subTeam = allData.firstWhere(
        (t) => t.managerId == emp.id,
        orElse: () =>
            TeamTreeEntity(managerId: 0, managerName: '', employees: []),
      );

      if (subTeam.managerId != 0 && subTeam.employees.isNotEmpty) {
        // Recursively add their team
        _addSubTeam(empNode, subTeam, allData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final provider = context.watch<TeamTreeProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text("Error: ${provider.error}"));
    }

    final data = provider.teamTree;
    if (data.isEmpty) {
      return const Center(child: Text("No team data available"));
    }

    graph.nodes.clear();
    graph.edges.clear();

    /// Build hierarchical graph
    _buildHierarchicalGraph(data);

    return Scaffold(
      appBar: KAppBar(
        title: "Team Tree",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 800.h, // Increased height for hierarchy
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: EdgeInsets.all(100.w),
            minScale: 0.2,
            maxScale: 3.0,
            child: GraphView(
              graph: graph,
              algorithm: BuchheimWalkerAlgorithm(
                builder,
                TreeEdgeRenderer(builder),
              ),
              paint: (Paint()
                ..color =
                    theme.textTheme.headlineLarge?.color ?? AppColors.titleColor
                ..strokeWidth = 2),

              builder: (Node node) {
                final nodeId = node.key!.value as String;

                if (nodeId.startsWith("manager_")) {
                  final managerId = int.parse(nodeId.split("_")[1]);
                  final manager = data.firstWhere(
                    (m) => m.managerId == managerId,
                  );
                  return _buildEmployeeCard(
                    manager.managerName,
                    "CEO/Founder",
                    null,
                  );
                } else if (nodeId.startsWith("emp_")) {
                  final empId = int.parse(nodeId.split("_")[1]);
                  final employee = data
                      .expand((m) => m.employees)
                      .firstWhere((e) => e.id == empId);

                  // Check if this employee is also a manager
                  final isAlsoManager = data.any(
                    (team) => team.managerId == empId,
                  );
                  final role = isAlsoManager
                      ? "${employee.designation} / Manager"
                      : employee.designation;

                  return _buildEmployeeCard(
                    employee.empName,
                    role,
                    employee.profilePhoto,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
