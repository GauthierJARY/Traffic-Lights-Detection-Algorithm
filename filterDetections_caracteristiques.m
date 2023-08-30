function [y_valid,x_valid] = filterDetections_caracteristiques(y,x,L,RGYB)

% Les feux de signalisation sont en fait un boitier noir possédant 3 
% ampoules, cette zone noire peut servir à filtrer les candidats. 
%
% Ce script s'appuie sur plusieures fonctions en BAS DE PAGE. 

% Initialisation des variables de sortie:

x_valid = 0;
y_valid = 0;

if(x>=1&&y>=1)
    % Il nous faut détecter le centre afin de  vérifier si un rectangle 
    % noir se trouve bien en dessous
    [x,y] = find_center(x,y,RGYB);
    % Afin d'améliorer la précision nous cherchons à estimer la dimension
    % du feu. En effet plus le feu est proche, plus il sera grand.
    [bas_lampe,haut_lampe,cote_lampe_g,cote_lampe_d]=find_size(x,y,RGYB);
    % Si la lampe a une forme plus ou moins circulaire:
    if(haut_lampe/bas_lampe<=2&&cote_lampe_g/cote_lampe_d<=2&&haut_lampe/cote_lampe_g<=2)
        [height,width]= size(L);
        % seuil sous lequel on considère que la luminosité peut être celle
        % d'un boitier de feu de signalisation.
        seuil_darkness = 30;
        % estimation de la taille du feu afin de tester la présence de la
        % zone noire
        bas_feu = 3*(bas_lampe+haut_lampe);
        cote_lampe = min(cote_lampe_g,cote_lampe_d);%idem
        moy = mean(L([min(height-1,y+bas_lampe):min(height-1,y+bas_feu)],[max(1,x-cote_lampe):min(width,x+cote_lampe)]),'all'); % On moyenne la luminosité dans la zone
        
        if(moy<seuil_darkness) % on teste la valeur moyenne
            x_valid = x;
            y_valid = y;
        else
            % Marqueur pour repérer la raison pour laquelle on a refusé
            % le candidat, ici, une zone noire n'est pas détectée. 
            rectangle('Position',[x,y,5,5],'EdgeColor', 'g','LineWidth',2)
            x_valid = -500;
            y_valid = -500;
        end
    else
        % Marqueur pour repérer la raison pour laquelle on a refusé le
        % candidat, ici, sa forme ne s'inscrit pas dans un carré (on
        % rejette ainsi les triangles ou rectangle, tout en conservant les
        % cercles qui s'inscrivent dans des carrés). 
        rectangle('Position',[x,y,5,5],'EdgeColor', 'b','LineWidth',2)
        x_valid = -500;
        y_valid = -500;
    end
end
end


% FONCTION ANNEXE : trouver le centre de la lampe

function [x_center,y_center] = find_center(x,y,RGYB)

%INITIALISATION
[height,width]= size(RGYB);
i_max = 1;
i_min = 1;
j_max = 1;
j_min = 1;
% Il nous faut la aussi un seuil qui servira à éliminer les pixels n'étant
% pas suffisament rouges.
seuil = 0.6*RGYB(y,x);

while(x+i_max<width && RGYB(y,x+i_max)>seuil)
    % On s'arrête dès qu'on atteint un pixel à droite dont le rouge n'est
    % pas assez intense
    i_max=i_max+1;
end
while(x-i_min>1 && RGYB(y,x-i_min)>seuil) % Idem à gauche
    i_min=i_min+1;
end
while(y+j_max<height && RGYB(y+j_max,x)>seuil) % Idem en bas
    j_max=j_max+1;
end
while(y-j_min>1 && RGYB(y-j_min,x)>seuil) % Idem en haut
    j_min=j_min+1;
end
x_center = round(x +0.5*(-i_min+i_max)); % La moyenne donne le centre
y_center = round(y +0.5*(-j_min+j_max));
end


% FONCTION ANNEXE: trouver la taille de la lampe

function [bas_lampe,haut_lampe,cote_lampe_g,cote_lampe_d] = find_size(x_center,y_center,RGYB)

%INITIALISATION
i_max = 1;
i_min = 1;
j_max = 1;
j_min = 1;
[height,width]= size(RGYB);
% Il nous faut la aussi un seuil qui servira à éliminer les pixels n'étant
% pas suffisament rouges
seuil = 0.6*RGYB(y_center,x_center);

% On effectue le même test, mais sur le centre afin cette fois de récupérer
% la largeur et la hauteur du feu.
while(x_center+i_max<width && RGYB(y_center,x_center+i_max)>seuil)
    i_max=i_max+1;
end
while(x_center-i_min>1 && RGYB(y_center,x_center-i_min)>seuil)
    i_min=i_min+1;
end
while(y_center+j_max<height && RGYB(y_center+j_max,x_center)>seuil)
    j_max=j_max+1;
end
while(y_center-j_min>1 && RGYB(y_center-j_min,x_center)>seuil)
    j_min=j_min+1;
end

% Correction de l'effet halo créant un feu de taille trop
if(j_max >=3 && j_min>=3 && i_min >=3 && i_max >= 3)
    j_max = round(j_max*0.75);
    j_min = round(j_min*0.75);
    i_max = round(i_max*0.75);
    i_min = round(i_min*0.75);
end
bas_lampe = j_max;
haut_lampe = j_min;
cote_lampe_d = i_max;
cote_lampe_g = i_min;
end