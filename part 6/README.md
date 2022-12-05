# BE-Fortran
Le but de ce Bureau d'étude est de simuler une expérience de diffusion au sein d'un milieu à une dimension par une méthode itérative déduisant la concentration au temps T en un point x de l'espace discrétisé par somme pondérée de proche en proche.
Cette méthode permet d'observer des resultats proches de ceux attendus théoriquement, mais a des limites issues de la discrétisation spatiale et temporelle. 

Le programme présenté ici permet de donner l'état d'un système au temps T lorsque l'on introduit une espèce se diffusant depuis x = 0 dans la direction de x = +infini. Ce résultat est donné sous la forme de deux courbes de C (la concentration en mole.m^-1) sur x (en m) issues du calcul itératif d'une part, et de calculs théoriques (supposés de référence) d'autre part.

Comment utiliser le programme en l'état:
- entrer les données dans le fichier donnees.dat
- éxecuter main.exe
- modifier la valeur de t voulue dans le code de affichage.py (T le temps d'étude = Dt*t)
- éxecuter affichage.py
- le graphique représentant C(x) et Cthéorique(x) à t fixé issu du programme sera stocké aux côtés de l'éxuctable en tant que "res.png"

Données à préciser avant d'utiliser le programme:
L : longueur du domaine étudié selon x (m)
D : diffusivité massique de l'agent polluant (m^2/s)
C0 : Concentration initiale du polluant 
xd : position du début de la zone de pollution (m)
xf : position de fin de la zone de pollution (m)
N : nombre de pas d'espace
Dt : pas de temps 
Nt : nb de pas de temps