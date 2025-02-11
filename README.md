# KiCad Setup
*Instructions fait en fonction de Kicad 8*  


# Installation
1. Pour commencer, faite l'installation du logiciel [KiCad](https://kicad.org/download/).  
2. Cloner le repo [KiCad_Library](https://github.com/MEC-ETS/KiCad_Library) sur votre ordinateur à un endroit permanent (ex.: C:/MEC_ETS/).
3. Une fois l'installation de KiCad complétée, démarrer le logiciel.

## Configuration des chemins d'accès
1. Dans la fenêtre principale de KiCad, dans préférence, ouvrir *Configurer les Chemins* 
2. Changer KICAD8_SYMBOL_DIR  pour *[Votre PATH]/KiCad_Library/Symbols*.  
**KICAD8_SYMBOL_DIR est le path pour les symboles**
3. Changer KICAD8_3DMODEL_DIR pour *[Votre PATH]/KiCad_Library/3D_Models*  
**KICAD8_3DMODEL_DIR est le path pour les modèles 3D.** 
4. Changer KICAD8_FOOTPRINT_DIR pour *[Votre PATH]/KiCad_Library/Footprint*  
**KICAD8_FOOTPRINT_DIR est le path pour les footprints**

## Library Tables
KiCad utilise des tables pour savoir quelles sont les libraries utilisées et leur emplacement. On dois donc ajouter nos libraries de pièces dans la configuration locale de KiCad.

### Table des symboles
1. Ouvrir l'éditeur de symboles
2. Ouvrir le menu préférence en haut
3. Sélectionner ```Configurer les libraries de symboles``` (```Manage Symbol Library```)
4. Si le tableau contient déjà des éléments, supprimer tous les éléments de la table (clique sur le premier élément, shift + clique sur le dernier)
5. Cliquer sur l'icone de dossier pour ajouter nos librairies à la table  
![kicad_symbole_ajout_lib.jpg](/kicad_symbole_ajout_lib.jpg)
6. Selectionner tous les fichiers de type ```.kicad_sym``` du dossier ```Symbols``` et cliquer ```ouvrir```  
![kicad_symbole_ajout_lib_ouvrir.jpg](/kicad_symbole_ajout_lib_ouvrir.jpg)
7. Fermer la fenetre en cliquant sur ```OK```
8. Fermer l'Éditeur de symboles


### Table des Footprints  
1. Ouvrir l'éditeur de Footprint
2. Ouvrir le menu préférence en haut
3. Sélectionner ```Configurer les libraries d'empreintes``` (```Manage Footprint Library```)
4. Supprimer tous les éléments de la table (clique sur le premier élément, shift + clique sur le dernier)
4. Cliquer sur l'icone de dossier pour ajouter nos librairies à la table  
![kicad_symbole_ajout_lib.jpg](/kicad_symbole_ajout_lib.jpg)
5. Selectionner tous les dossiers de type ```.pretty``` du dossier ```Footprints``` et cliquer sur ```ok``` 
![kicad_footprint_ajout_lib_ouvrir.jpg](/kicad_footprint_ajout_lib_ouvrir.jpg)
6. Fermer la fenetre en cliquant sur ```OK```
7. Fermer l'Éditeur d'empreinte


# Nouvelle Piece
Tous les composants doivent être uniques dans l'éditeur de schéma pour que l'on puisse générer les BOMs. Les Footprints et les modèles 3D eux ne sont pas uniques. 
**Toutes les pièces doivent avoir un modèle 3D et un footprint assigné.**
**Les modèles 3D doivent avoir un modèle de format .STEP**

La librairie est faite pour que la création de pièce soit rapide et efficace. Les informations que vous avez besoin devraient toutes se retrouver sur Digikey.

### Composantes

* Pour une composante dont le symbole ou une composante similaire est déjà créé

1. Ouvrir l'éditeur de symboles;
2. Dupliquer la composante similaire;
3. Modifier les informations de la pièces.

* Pour une composante créé a partir de zéro  

1. Ouvrir l'éditeur de symboles;
2. Sélectionner la librairie correspondante;
3. Cliquer sur 'Create new symbol';

* Remplir les informations nécessaire
1. Dans **Edit component properties**, dans l'onglet **Description** :  
*Description* : Copiez la description de Digikey.  
*Keywords* : Series, Type de pièce, etc. Cette information sert pour l'outil de recherche.  
*Documentation File Name* : Copiez le lien de la datasheet.
2. Dans **Add and remove field and edit field properties** (le T), remplir les champs :  
*Reference* : Lettre représentant la famille ou type de composant. Exemple, pour une résistance : R.  
(Voir : https://en.wikipedia.org/wiki/Reference_designator)  
*Value* : Nom du composant. Devrait déjà être rempli.  
*Footprint* : Assignation du footprint. Utilisez **Assign Footprint**.  
*Datasheet* : Lien vers la datasheet.  
*Supplier* : Nom du fournisseur, EX: Digikey, Mouser, etc.  
*Supplier Part Number* : Numéro de composant provenant du fournisseur.  
*Manufacturer* : Copier l'information du fournisseur.  
*Manufacturer Part Number* : Copier l'information du fournisseur.  
*Description* : Copier l'information du fournisseur.  
*Champs propre au type de composant* : Mettre les champs avec l'information nécessaire propre au type de composant. Exemple, pour une résistance, seulement mettre : Valeur de résistance, puissance, tolérance.

### Footprint
1. Ouvrir l'éditeur de footprint;
2. Sélectionner la **bonne librairie** dans **Select active library** (Premier icône en haut à gauche);
3. Créé un nouveau footprint avec **New Footprint**
4. Sauvegarder avec un nom **Significatif**. Utilisez le nom standard si le footprint est commun ex: **SOIC-8**. Si le footprint n'est pas commun, utilisez le nom de la **série** de la pièce ou dans le pire des cas son **Manufacturer Part Number**.

