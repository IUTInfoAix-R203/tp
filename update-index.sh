#!/bin/bash
# Génère automatiquement la table des TP dans README.md en lisant les
# liens Classroom depuis chaque repo IUTInfoAix-R203/tpN.
#
# Usage : ./update-index.sh
# Nécessite : gh (GitHub CLI) authentifié
#
# NOTE : ce script bypasse le piège de la redirection 301 vers
# IUTInfoAix-R203-archive/tpN en vérifiant explicitement que le
# repo répondu est bien dans la nouvelle orga (pas l'archive).

set -euo pipefail

ORG="IUTInfoAix-R203"
COURS_URL="https://iutinfoaix-r203.github.io/cours"

# Configuration des TP : numéro|titre|thème|semaine
TPS=(
  "1|Git avancé et bonnes pratiques|Rebase, cherry-pick, PR + code review, Conventional Commits|1"
  "2|TDD|Cycle RED-GREEN-REFACTOR, fake-it, triangulation, approval testing|2"
  "3|Kata et pair programming|Driver/navigator, kata Bowling / Tennis / Yahtzee|3"
  "4|Refactoring|Code smells, refactorings de Fowler, characterization tests, Gilded Rose|4"
)

# Configuration des CM : numéro|titre|slug du fichier
CMS=(
  "1|Artisanat logiciel, qualité, Git avancé|cm1-artisanat-et-git"
  "2|TDD, refactoring, code smells, Clean Code|cm2-tdd-refactoring"
)

# Extraire le lien Classroom d'un repo, en évitant les redirections
# automatiques vers IUTInfoAix-R203-archive.
get_classroom_link() {
  local repo="$1"
  # gh api retourne le full_name réel (suit les redirects),
  # donc on peut détecter si on est tombé sur l'archive
  local info
  info=$(gh api "repos/$ORG/$repo" 2>/dev/null) || return 1
  local full_name
  full_name=$(echo "$info" | python3 -c "import sys,json; print(json.load(sys.stdin)['full_name'])" 2>/dev/null)

  # Refuse les redirections vers l'archive
  if [ "$full_name" != "$ORG/$repo" ]; then
    return 1
  fi

  # Récupère le README et extrait le lien Classroom
  local readme
  readme=$(gh api "repos/$ORG/$repo/readme" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null) || return 1
  local link
  link=$(echo "$readme" | grep -oP 'https://classroom\.github\.com/a/[a-zA-Z0-9_-]+' | head -1)

  # Ignore le placeholder XXXXXX (lien par défaut de create-tp.sh,
  # pas encore remplacé par le vrai slug Classroom).
  if [ -n "$link" ] && [[ "$link" != *XXXXXX* ]]; then
    echo "$link"
  else
    return 1
  fi
}

# Vérifier si un fichier de cours existe sur GitHub Pages
check_cm_exists() {
  local slug="$1"
  curl -sf -o /dev/null "$COURS_URL/$slug.html" 2>/dev/null
}

echo "Génération de l'index des TP..."

# Construire la table des TP
TP_TABLE="| Semaine | TP | Thème | Lien Classroom |
|---|---|---|---|"

for tp_config in "${TPS[@]}"; do
  IFS='|' read -r num titre theme semaine <<< "$tp_config"
  repo="tp$num"
  echo -n "  TP$num ($titre)... "

  link=$(get_classroom_link "$repo" 2>/dev/null || true)
  if [ -n "$link" ]; then
    TP_TABLE="$TP_TABLE
| $semaine | **TP$num - $titre** | $theme | [Accepter le TP$num]($link) |"
    echo "OK ($link)"
  else
    TP_TABLE="$TP_TABLE
| $semaine | **TP$num - $titre** | $theme | *à venir* |"
    echo "pas encore publié"
  fi
done

# Construire la table des CM
CM_TABLE="| CM | Thème | Slides |
|---|---|---|"

for cm_config in "${CMS[@]}"; do
  IFS='|' read -r num titre slug <<< "$cm_config"
  echo -n "  CM$num ($titre)... "

  if check_cm_exists "$slug"; then
    CM_TABLE="$CM_TABLE
| CM$num | $titre | [Voir les slides]($COURS_URL/$slug.html) |"
    echo "OK"
  else
    CM_TABLE="$CM_TABLE
| CM$num | $titre | *à venir* |"
    echo "pas encore publié"
  fi
done

# Générer le README complet
cat > README.md << HEREDOC
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
> Pour chaque TP, vous devez **accepter le devoir** via le lien Classroom ci-dessous. Cela crée automatiquement un dépôt à votre nom dans l'organisation \`IUTInfoAix-R203-2026\`. C'est dans ce dépôt que vous travaillez et (à partir du TP2) que votre progression est évaluée automatiquement.

---

## Travaux pratiques

$TP_TABLE

> [!NOTE]
> Le **TP1 est un TP de mise à niveau non noté**. Il vise à corriger les mauvaises habitudes Git acquises au S1 et à introduire les concepts avancés que vous utiliserez toute la suite. Les TP2, TP3 et TP4 sont **autograndés** (note sur 100 points calculée à chaque push).

---

## Cours magistraux

$CM_TABLE

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
- **Maven** (via le wrapper \`./mvnw\` - aucune installation nécessaire)
- **GitHub Codespaces** (environnement de développement dans le navigateur)
- **JUnit Jupiter 6** + **AssertJ** + **Mockito** + **ApprovalTests** (tests automatiques)

---

<!-- Dernière mise à jour : $(date -Iseconds) -->
*IUT d'Aix-Marseille - Département Informatique - 2025-2026*
HEREDOC

echo ""
echo "README.md mis à jour."
