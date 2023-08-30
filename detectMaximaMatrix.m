function [ x , y , maxVals ] = detectMaximaMatrix (RGYB, nr_Maxima , boxSize)

% Fonction permettant de calculer les nr_Maxima sur une image en éliminant
% une box de pixels autour du maximum. 
% Fonction directement issue de detectMaxima.m, avec cette fois-ci une
% élimination des pixels en ajoutant une matrice nulle plutôt que de les
% parcourir un à un. 

x=zeros(nr_Maxima,1);
y=zeros(nr_Maxima,1);
maxVals=zeros(nr_Maxima,1);

for k=1:nr_Maxima
    taille=size(RGYB);
    hauteur=taille(1,1);
    largeur=taille(1,2);
    % recupère la valeur max et sa position
    [maxValue, coord] = max(RGYB(:));
    [ligne, colonne] = ind2sub(size(RGYB), coord);
    valeur_min=min(RGYB); %on récupère le min
    valeur_min=valeur_min(1,1);
    % délimitation de la box à éliminer
    cmx=ligne-boxSize/2;
    cMx=ligne+boxSize/2;
    cmy=colonne-boxSize/2;
    cMy=colonne + boxSize/2;
    % on vérifie que la box ne sort pas de l'image
    if cmx<1
        cmx=1;
    end
    if cMx>largeur
        cMx=largeur;
    end
    if cmy<1
        cmy=1;
    end
    if cMy>hauteur
        cMy=hauteur;
    end
    %on modifie directement la matrice sans parcourir les pixels
    % on mets ces pixels à la valeur min
    RGYB(cmx:cMx ,cmy:cMy)=valeur_min;
    x(k,1)=ligne;
    y(k,1)=colonne;
    maxVals(k,1)=maxValue;
end
% En ayant recourt à des tic toc, on trouve que la fonction est en moyenne
% 0.0002 secondes plus rapide, donc à peine significatif face à la pause de
%0.001 mis pour passer les images en vidéo.
% On ne peut pas parler d'optimisation et on conservera la détection
% classique des maxima. 
end
