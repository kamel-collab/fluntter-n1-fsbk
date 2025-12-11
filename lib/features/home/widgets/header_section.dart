import 'package:flutter/material.dart';
import '../../../core/widgets/circle_icon_button.dart';
import '../../../core/widgets/dot.dart';
import '../../../core/widgets/graph_widget.dart';
import '../models/account.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final PageController _controller = PageController();

  int currentPage = 0;
  bool isHidden = false;

  final List<Account> accounts = const [
    Account(
      label: "CPTES CHEQUES PERS.FRANSABANK",
      solde: 2589.50,
      veille: 3189.50,
    ),
    Account(label: "COMPTE ÉPARGNE", solde: 12000.00, veille: 11800.00),
    Account(label: "COMPTE PROFESSIONNEL", solde: 460000.75, veille: 459800.20),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF004AAD), Color(0xFF005FCC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          const SizedBox(height: 24),
          _accountsPageView(),
          const SizedBox(height: 16),
          _dotsIndicator(),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        CircleIconButton(icon: Icons.menu, onTap: () {}),
        const SizedBox(width: 8),

        CircleIconButton(
          icon: isHidden ? Icons.visibility_off : Icons.visibility,
          onTap: () => setState(() => isHidden = !isHidden),
        ),
        const SizedBox(width: 8),

        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    accounts[currentPage].label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),
        CircleIconButton(icon: Icons.notifications_none, onTap: () {}),
        const SizedBox(width: 8),
        CircleIconButton(icon: Icons.qr_code_2, onTap: () {}),
      ],
    );
  }

  Widget _accountsPageView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 140,
            child: Opacity(opacity: 0.40, child: const AccountGraph()),
          ),
        ),

        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: accounts.length,
            onPageChanged: (i) => setState(() => currentPage = i),
            itemBuilder: (context, index) {
              final acc = accounts[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        isHidden ? "•••••" : acc.solde.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'DZD',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Solde Disponible',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isHidden ? "•••••" : acc.veille.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'DZD',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Solde veille',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ),

        if (currentPage > 0)
          Positioned(
            left: 8,
            child: GestureDetector(
              onTap: () => _controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              ),
              child: _arrow(),
            ),
          ),

        if (currentPage < accounts.length - 1)
          Positioned(
            right: 8,
            child: GestureDetector(
              onTap: () => _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              ),
              child: _arrow(isLeft: false),
            ),
          ),
      ],
    );
  }

  Widget _arrow({bool isLeft = true}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.22),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isLeft ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Widget _dotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        accounts.length,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Dot(isActive: i == currentPage),
        ),
      ),
    );
  }
}
