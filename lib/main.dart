import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceTrackerApp());
}

class EcommerceTrackerApp extends StatelessWidget {
  const EcommerceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce Business Master Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    OrdersTab(),
    ReturnsDisputeTab(),
    BankReconTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce Business Tracker'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Orders & Profit',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_return_outlined),
            selectedIcon: Icon(Icons.assignment_return),
            label: 'Returns & Disputes',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_outlined),
            selectedIcon: Icon(Icons.account_balance),
            label: 'Bank Recon',
          ),
        ],
      ),
    );
  }
}

// ---------------- TAB 1: ORDERS & PROFIT ----------------
class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildSummaryCard(),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Orders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.indigo, size: 28),
              onPressed: () {},
            )
          ],
        ),
        const SizedBox(height: 6),
        _buildOrderItem(
          orderId: "#1001",
          sku: "TWS Earbuds",
          status: "Delivered",
          statusColor: Colors.green,
          profit: "+₹489",
          profitColor: Colors.green,
          details: "SP: ₹1,299 | Cost: ₹520 | Ship: ₹110",
        ),
        _buildOrderItem(
          orderId: "#1002",
          sku: "Smart Tag",
          status: "RTO Undelivered",
          statusColor: Colors.orange,
          profit: "-₹185",
          profitColor: Colors.red,
          details: "Forward: ₹95 | RTO Ship: ₹90",
        ),
        _buildOrderItem(
          orderId: "#1003",
          sku: "Sports Watch",
          status: "Fake Return",
          statusColor: Colors.purple,
          profit: "-₹850 (Dispute)",
          profitColor: Colors.red,
          details: "Courier: Delhivery | Claim Raised",
        ),
        _buildOrderItem(
          orderId: "#1004",
          sku: "Trimmer Pro",
          status: "RTO Lost",
          statusColor: Colors.redAccent,
          profit: "-₹650 (Claimed)",
          profitColor: Colors.red,
          details: "Delhivery Lost in Transit",
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.indigo.shade50,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text("Total Revenue", style: TextStyle(color: Colors.black54, fontSize: 13)),
                SizedBox(height: 4),
                Text("₹28,500", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text("Net Profit", style: TextStyle(color: Colors.black54, fontSize: 13)),
                SizedBox(height: 4),
                Text("₹8,450", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            Column(
              children: [
                Text("RTO Loss", style: TextStyle(color: Colors.black54, fontSize: 13)),
                SizedBox(height: 4),
                Text("-₹1,685", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem({
    required String orderId,
    required String sku,
    required String status,
    required Color statusColor,
    required String profit,
    required Color profitColor,
    required String details,
  }) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text("$orderId — $sku", style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(details, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        trailing: Text(profit, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: profitColor)),
      ),
    );
  }
}

// ---------------- TAB 2: RETURNS & DISPUTES ----------------
class ReturnsDisputeTab extends StatelessWidget {
  const ReturnsDisputeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildDisputeItem(
          awb: "DELHI-987654321",
          orderId: "#1003",
          courier: "Delhivery",
          issue: "Fake Return: Soap bar received instead of watch",
          status: "Ticket Raised (Pending)",
          statusColor: Colors.orange,
        ),
        _buildDisputeItem(
          awb: "DELHI-123456789",
          orderId: "#1004",
          courier: "Delhivery",
          issue: "Lost in Transit: Stuck at Kolkata Hub for 10 days",
          status: "Claim Approved (₹650 credited)",
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildDisputeItem({
    required String awb,
    required String orderId,
    required String courier,
    required String issue,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("AWB: $awb", style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(courier, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 6),
            Text("Order: $orderId", style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(issue, style: const TextStyle(fontSize: 13, color: Colors.black54)),
            const Divider(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11)),
                  backgroundColor: statusColor.withOpacity(0.12),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.link, size: 16),
                  label: const Text("Proof Link", style: TextStyle(fontSize: 12)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- TAB 3: BANK RECON ----------------
class BankReconTab extends StatelessWidget {
  const BankReconTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildReconItem(
          date: "15 Oct 2026",
          source: "Delhivery COD Remittance",
          utr: "UTR9823471029",
          expected: "₹14,850",
          credited: "₹14,850",
          diff: "₹0",
          isMatch: true,
        ),
        _buildReconItem(
          date: "12 Oct 2026",
          source: "Delhivery COD Remittance",
          utr: "UTR8823100293",
          expected: "₹8,200",
          credited: "₹7,400",
          diff: "-₹800 (Deduction Dispute)",
          isMatch: false,
        ),
      ],
    );
  }

  Widget _buildReconItem({
    required String date,
    required String source,
    required String utr,
    required String expected,
    required String credited,
    required String diff,
    required bool isMatch,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(source, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Date: $date | UTR: $utr\nExpected: $expected | Credited: $credited"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isMatch ? "MATCHED" : "MISMATCH",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isMatch ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 2),
            Text(diff, style: TextStyle(fontSize: 11, color: isMatch ? Colors.black54 : Colors.red)),
          ],
        ),
      ),
    );
  }
}
