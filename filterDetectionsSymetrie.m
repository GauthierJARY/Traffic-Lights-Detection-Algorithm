function [x,y]= filterDetectionsSymetrie(RGYB,x,y,seuil,n_max)

% Ce filtre est la première tentative de filtre géométrique des candidats.
% On regarde si les pixels dans une croix autour du maximums sont
% suffisemment lumineux et rouges, c'est à dire dépassent le seuil.

ecart=20; % nombre de pixels autour
% calcul des coordonnées des pixels autour
yu=y+ecart;
yd=y-ecart;
xu=x+ecart;
xd=x-ecart;

for i=1:n_max
    if x(i)>0
        if  yu(i)<640 & yd(i)>2 & xu(i)<160 & xd(i)>2
            if RGYB(x(i),yu(i))<seuil || RGYB(x(i),yd(i))<seuil || RGYB(xu(i),y(i))<seuil || RGYB(xd(i),y(i))<seuil || RGYB(xu(i),yu(i))<seuil || RGYB(xd(i),yd(i))<seuil || RGYB(xd(i),yu(i))<seuil || RGYB(xu(i),yd(i))<seuil
                a="no radial"
                % On affiche les faux positifs pour ajuster les valeurs 
                % numériques de ecart et vérifier le bon comportement du
                % filtre.
                rectangle('Position',[y(i),x(i),10,10],'EdgeColor', 'g','LineWidth',2)
                x(i)=0;
                y(i)=0;
            end
        end
    end
end
x;
y;
end
