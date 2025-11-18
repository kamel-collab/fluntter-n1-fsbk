import 'package:flutter/material.dart';
import 'package:first/circle_icon_button.dart';
import 'package:first/dot.dart';

class BankAccount {
  final String label;
  final double solde;
  final double veille;

  BankAccount({required this.label, required this.solde, required this.veille});
}

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  /*
    PageController :
    ----------------
    Sert à contrôler un PageView (changer de page, écouter le scroll, etc.)
    Il permet de faire défiler les comptes vers la gauche/droite
    et déclencher des actions comme "nextPage()" ou "previousPage()".
  */
  final PageController _controller = PageController();

  int currentPage = 0;
  bool isHidden = false;

  final List<BankAccount> accounts = [
    BankAccount(
      label: "CPTES CHEQUES PERS.FRANSABANK",
      solde: 2589.50,
      veille: 3189.50,
    ),
    BankAccount(label: "COMPTE ÉPARGNE", solde: 12000.00, veille: 11800.00),
    BankAccount(
      label: "COMPTE PROFESSIONNEL",
      solde: 460000.75,
      veille: 459800.20,
    ),
  ];

  @override
  void dispose() {
    /*
      dispose() :
      -----------
      Méthode appelée lorsque le widget est retiré de l'écran.
      On y libère les ressources (ici : le PageController).
      C'est une bonne pratique pour éviter les fuites mémoire.
    */
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
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white),
          padding: EdgeInsets.zero,
        ),
        const SizedBox(width: 8),

        IconButton(
          onPressed: () {
            setState(() => isHidden = !isHidden);
          },
          icon: Icon(
            isHidden ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 8),

        /*
          Expanded :
          ----------
          Permet au widget de prendre tout l'espace horizontal disponible.
          Sans Expanded, le container serait limité et les icônes déborderaient.
          Ici, Expanded pousse les boutons à gauche et à droite en prenant la place centrale.
        */
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
                const SizedBox(width: 4),
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
        SizedBox(
          height: 160,

          /*
            PageView.builder :
            ------------------
            Un carrousel défilable d’éléments.
            "builder" = construit uniquement les pages visibles (performant).
            - controller : pour contrôler le scroll
            - onPageChanged : callback quand on change de page
          */
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
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

        /* ----------- FLÈCHE GAUCHE ----------- */
        if (currentPage > 0)
          Positioned(
            left: 8,

            /*
              GestureDetector :
              -----------------
              Widget qui détecte les interactions de l'utilisateur.
              Ici, onTap déclenche un changement de page vers la gauche.
            */
            child: GestureDetector(
              onTap: () {
                /*
                  previousPage() :
                  ----------------
                  Fait défiler le PageView vers la page précédente
                  avec une animation fluide.
                */
                _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),

        /* ----------- FLÈCHE DROITE ----------- */
        if (currentPage < accounts.length - 1)
          Positioned(
            right: 8,
            child: GestureDetector(
              onTap: () {
                /*
                  nextPage() :
                  ------------
                  Fait défiler le PageView vers la prochaine page
                  (même animation que previousPage).
                */
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _dotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      /*
        List.generate :
        --------------
        Crée une liste dynamique de widgets.
        Ici : un Dot() pour chaque page (compte bancaire).
        - i == currentPage permet de savoir quel point doit être "actif".
      */
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
