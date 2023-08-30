function [xpassed, ypassed] = filterDetectionsThreshold(x,y,RGYB,threshold)

% premier filtre, pour sélectionner les candidats: on veut les éléments les
% plus rouges et lumineux de l'image, mais qui dépassent une certaine
% valeur de seuil threshold.

for i=1:length(x)
    
 % On pourrait peut être améliorer l'execution de cette fonction avec les 
 % opérations matricielles booléennes.  
 % La valeur du threshold a été déterminée après une étude de la valeur 
 % moyenne de sortie RGYB moyenne des feux.
 % La valeur du threshold est soumise à discussion. 
 % En effet, cette valeur peut varier : brouillard, luminosité, type de
 % feux, modèle de caméra. 
 
if RGYB(x(i),y(i),:)<threshold 
    x(i)=0;
    y(i)=0;
end  
end
xpassed=x;
ypassed=y;
end