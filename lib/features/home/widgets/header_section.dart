import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/circle_icon_button.dart';
import '../../../core/widgets/dot.dart';
import '../../../core/widgets/graph_widget.dart';

import 'package:first/blocs/header/header_bloc.dart';
import 'package:first/blocs/header/header_event.dart';
import 'package:first/blocs/header/header_state.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeaderBloc, HeaderState>(
      builder: (context, state) {
        final bloc = context.read<HeaderBloc>();

        // 🔄 Chargement
        if (state.isLoading) {
          print("loading");
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ Erreur UNIQUEMENT s’il n’y a aucune donnée
        if (state.error != null && state.accounts.isEmpty) {
          return const SizedBox(
            height: 220,
            child: Center(
              child: Text(
                "Erreur de chargement",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        // 📭 Aucun compte
        if (state.accounts.isEmpty) {
          return const SizedBox(
            height: 220,
            child: Center(
              child: Text(
                "Aucun compte disponible",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        // ✅ Données disponibles → affichage normal
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
              _topBar(state, bloc),
              const SizedBox(height: 24),
              _accountsPageView(state, bloc),
              const SizedBox(height: 16),
              _dotsIndicator(state),
            ],
          ),
        );
      },
    );
  }

  // ───────────────── TOP BAR ─────────────────
  Widget _topBar(HeaderState state, HeaderBloc bloc) {
    final acc =
        state.accounts[state.currentPage.clamp(0, state.accounts.length - 1)];

    return Row(
      children: [
        CircleIconButton(icon: Icons.menu, onTap: () {}),
        const SizedBox(width: 8),

        CircleIconButton(
          icon: state.isHidden ? Icons.visibility_off : Icons.visibility,
          onTap: () => bloc.add(HeaderToggleHidden()),
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
                    acc.label,
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

  // ───────────────── PAGE VIEW ─────────────────
  Widget _accountsPageView(HeaderState state, HeaderBloc bloc) {
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
            itemCount: state.accounts.length,
            onPageChanged: (i) => bloc.add(HeaderCurrentPageChanged(i)),
            itemBuilder: (context, index) {
              final acc = state.accounts[index];

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        state.isHidden ? "•••••" : acc.solde.toStringAsFixed(2),
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
                        state.isHidden
                            ? "•••••"
                            : acc.veille.toStringAsFixed(2),
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

        if (state.currentPage > 0)
          Positioned(
            left: 8,
            child: GestureDetector(
              onTap: () => _controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              ),
              child: _arrow(isLeft: true),
            ),
          ),

        if (state.currentPage < state.accounts.length - 1)
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

  // ───────────────── ARROW ─────────────────
  Widget _arrow({required bool isLeft}) {
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

  // ───────────────── DOTS ─────────────────
  Widget _dotsIndicator(HeaderState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        state.accounts.length,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Dot(isActive: i == state.currentPage),
        ),
      ),
    );
  }
}
