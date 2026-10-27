import 'package:flutter/material.dart';

void main() => runApp(const TipCalculatorApp());

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087E78)),
        scaffoldBackgroundColor: const Color(0xFFF3F6F5),
      ),
      home: const TipCalculatorPage(),
    );
  }
}

class TipCalculatorPage extends StatefulWidget {
  const TipCalculatorPage({super.key});

  @override
  State<TipCalculatorPage> createState() => _TipCalculatorPageState();
}

class _TipCalculatorPageState extends State<TipCalculatorPage> {
  final TextEditingController _billController =
      TextEditingController(text: '1000');
  double _tipPercent = 10;
  int _people = 4;

  double get _bill => double.tryParse(_billController.text.trim()) ?? 0;
  double get _tip => _bill * _tipPercent / 100;
  double get _total => _bill + _tip;
  double get _perPerson => _total / _people;

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  String _money(double amount) => '₹${amount.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF3F6F5),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              children: [
                Text(
                  'Split the bill, keep it simple.',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF172B3A),
                      ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Enter the bill and choose a tip to see each person’s share.',
                  style: TextStyle(color: Color(0xFF62736F), height: 1.4),
                ),
                const SizedBox(height: 22),
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xFFE3ECE8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: TextField(
                      controller: _billController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Bill amount',
                        prefixText: '₹ ',
                        border: OutlineInputBorder(),
                        helperText: 'You can enter whole or decimal amounts',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xFFE3ECE8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tip percentage',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${_tipPercent.round()}%',
                              style: const TextStyle(
                                color: Color(0xFF087E78),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _tipPercent,
                          min: 0,
                          max: 30,
                          divisions: 30,
                          label: '${_tipPercent.round()}%',
                          onChanged: (value) =>
                              setState(() => _tipPercent = value),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Split between',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              IconButton(
                                tooltip: 'Remove one person',
                                onPressed: _people > 1
                                    ? () => setState(() => _people--)
                                    : null,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  '$_people',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              IconButton(
                                tooltip: 'Add one person',
                                onPressed: () => setState(() => _people++),
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                              const Text('people'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF123D40),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'YOUR SHARE',
                        style: TextStyle(
                          color: Color(0xFFB8D8D0),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _money(_perPerson),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 18),
                      _ResultLine(label: 'Tip amount', value: _money(_tip)),
                      const SizedBox(height: 10),
                      _ResultLine(label: 'Total bill', value: _money(_total)),
                      const SizedBox(height: 10),
                      _ResultLine(
                        label: 'Each person',
                        value: '$_people ${_people == 1 ? 'person' : 'people'}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultLine extends StatelessWidget {
  const _ResultLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFFD4E5E1))),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

