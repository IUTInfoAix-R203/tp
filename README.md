# <img src="https://raw.githubusercontent.com/IUTInfoAix-R510/Syllabus/main/assets/logo.png" alt="class logo" class="logo"/> R2.03 - Qualité de développement

### IUT d'Aix-Marseille - Département Informatique Aix-en-Provence

* **Ressource :** [R2.03](https://cache.media.enseignementsup-recherche.gouv.fr/file/SPE4-MESRI-17-6-2021/35/5/Annexe_17_INFO_BUT_annee_1_1411355.pdf)

* **Responsable :** [Sébastien Nedjar](mailto:sebastien.nedjar@univ-amu.fr)

* **Enseignantes :**

  * [Sophie Nabitz](mailto:sophie.nabitz@univ-avignon.fr)
  * [Leïla Sakli Miled](mailto:leila.SAKLI@univ-amu.fr)

* **Besoin d'aide ?** [Email](mailto:sebastien.nedjar@univ-amu.fr) pour toute question

---

## Bienvenue

Ce module vous apprend les **pratiques de l'artisanat logiciel** : gestion de version avancée (Git), développement piloté par les tests (TDD), kata en pair programming, et refactoring de code existant. L'objectif est de transformer votre manière de coder - passer de "ça marche sur ma machine" à "je produis du code propre, testé, relu et maintenable".

Chaque semaine, un nouveau TP. Cliquez sur le lien Classroom correspondant pour créer votre dépôt personnel, puis ouvrez-le dans GitHub Codespaces pour travailler directement dans le navigateur.

> [!IMPORTANT]
> Pour chaque TP, vous devez **accepter le devoir** via le lien Classroom ci-dessous. Cela crée automatiquement un dépôt à votre nom dans l'organisation `IUTInfoAix-R203-2026`. C'est dans ce dépôt que vous travaillez et (à partir du TP2) que votre progression est évaluée automatiquement.

---

## Travaux pratiques

| Semaine | TP | Thème | Lien Classroom |
|---|---|---|---|
| 1 | **TP1 - Git avancé et bonnes pratiques** | Rebase, cherry-pick, PR + code review, Conventional Commits | [Accepter le TP1](https://classroom.github.com/a/yiTMNY-m) |
| 2 | **TP2 - TDD** | Cycle RED-GREEN-REFACTOR, fake-it, triangulation, approval testing | [Accepter le TP2](https://classroom.github.com/a/HP_p0YPk) |
| 3 | **TP3 - Kata et pair programming** | Driver/navigator, kata Bowling / Tennis / Yahtzee | *à venir* |
| 4 | **TP4 - Refactoring** | Code smells, refactorings de Fowler, characterization tests, Gilded Rose | *à venir* |

> [!NOTE]
> Le **TP1 est un TP de mise à niveau non noté**. Il vise à corriger les mauvaises habitudes Git acquises au S1 et à introduire les concepts avancés que vous utiliserez toute la suite. Les TP2, TP3 et TP4 sont **autograndés** (note sur 100 points calculée à chaque push).

---

## Cours magistraux

| CM | Thème | Slides |
|---|---|---|
| CM1 | Artisanat logiciel, qualité, Git avancé | *à venir* |
| CM2 | TDD, refactoring, code smells, Clean Code | *à venir* |

Deux démos **en direct** en début de séance TP complètent les CM : kata live en pair programming (avant le TP3) et refactoring IDE (avant le TP4).

---

## Comment travailler

1. **Acceptez le devoir** en cliquant sur le lien Classroom du TP de la semaine
2. **Ouvrez votre dépôt** dans GitHub Codespaces (bouton "Code" -> "Codespaces" -> "Create codespace on main")
3. **Lisez le README** du TP - il contient les objectifs, les explications et les exercices détaillés
4. **Travaillez par branche** : un exercice = une branche, validée par une Pull Request (workflow vu au TP1)
5. **Poussez votre code** régulièrement - à partir du TP2, votre score est calculé automatiquement à chaque push

> [!TIP]
> **Copilot Chat** est disponible dans votre Codespace comme tuteur. Il est configuré pour vous guider sans donner directement la solution : il commence par expliquer le concept, puis oriente vers la documentation, et ne propose du code qu'en dernier recours. N'hésitez pas à lui poser des questions quand vous bloquez.

---

## Évaluation

- **CC1** : moyenne des notes autograding des TP2 / TP3 / TP4 (sur 100 chacun, votre score augmente à chaque test qui passe) - coeff. 10
- **CC2** : participation, qualité des revues de PR, régularité des commits - coeff. 10
- **CC3** : mini-kata TDD sur feuille (2h, sans outil d'assistance) - coeff. 40

Le TP1 Git ne compte pas dans la note : c'est un TP de mise à niveau obligatoire mais non noté.

---

## Environnement technique

- **Java 25**
- **Maven** (via le wrapper `./mvnw` - aucune installation nécessaire)
- **GitHub Codespaces** (environnement de développement dans le navigateur)
- **JUnit Jupiter 6** + **AssertJ** + **Mockito** + **ApprovalTests** (tests automatiques)

---

<!-- Dernière mise à jour : 2026-04-22T14:55:11+02:00 -->
*IUT d'Aix-Marseille - Département Informatique - 2025-2026*
