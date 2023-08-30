function [ x , y , maxVals ] = detectMaxima (RGYB, nr_Maxima , boxSize)

% Fonction permettant de calculer les nr_Maxima sur une image en éliminant
% une box de pixels autour des valeurs trouvées.

x=zeros(nr_Maxima,1);
y=zeros(nr_Maxima,1);
maxVals=zeros(nr_Maxima,1);

for k=1:nr_Maxima
    % on prend nr_Maxima 
    taille=size(RGYB);
    hauteur=taille(1,1);
    largeur=taille(1,2);
    % recupère la valeur max et sa position en indice linéaire
    [maxValue, coord] = max(RGYB(:)); 
    % on transforme cette coordonnée linéaire en nos indices de colonne 
    % et ligne
    [ligne, colonne] = ind2sub(size(RGYB), coord); 
    % on récupère le minimum de valeur des pixels
    valeur_min=min(RGYB); 
    valeur_min=valeur_min(1,1);
    % on va parcourir tous les pixels dans la box autour du maximum
    for i=-boxSize:boxSize 
        for j=-boxSize:boxSize
            a=ligne+i;
            b=colonne+j;
            if a>=1 && a<=hauteur % on vérifie qu'on ne sort pas de l'image
                if b>=1 && b<=largeur %idem
                    % on mets la valeur du max à celle du min dans une 
                    % box_size tout  autour et on réitère l'algorithme
                    RGYB(a,b)=valeur_min;  
                end
            end
        end
    end
    x(k,1)=ligne;
    y(k,1)=colonne;
    maxVals(k,1)=maxValue;
end
