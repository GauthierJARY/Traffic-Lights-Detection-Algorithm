function [x,y]= filterRadial(RGYB,x,y,seuil,n_max)

% 2ème tentative de filtre géométrique après filterDetectionsSymetrie
% l'idée est de regarder les 8 pixels autour du maximum et vérifier si ces
% pixels sont supérieurs à la valeur du threshold. 
% En ce cas, on considère que le candidat est correct, sinon, on mets la
% valeur à 0. Ce filtre est censé éliminer les écritures et enseignes
% lumineuses rouges. 

ecart=1; % nombre de pixels autour 
% calcul des coordonnées des pixels contigues.
yu=y+ecart;
yd=y-ecart;
xu=x+ecart;
xd=x-ecart;

for i=1:n_max
    if x(i)>0
        if  yu(i)<640 && yd(i)>2 && xu(i)<160 && xd(i)>2 
            if RGYB(x(i),yu(i))<seuil || RGYB(x(i),yd(i))<seuil || RGYB(xu(i),y(i))<seuil || RGYB(xd(i),y(i))<seuil || RGYB(xu(i),yu(i))<seuil || RGYB(xd(i),yd(i))<seuil || RGYB(xd(i),yu(i))<seuil || RGYB(xu(i),yd(i))<seuil 
                % affichage des faux positifs: permet de se rendre compte
                % de l'efficacité du filtre, mais aussi des feux
                % injustement rejetés. 
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