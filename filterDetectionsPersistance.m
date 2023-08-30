function [x,y] = filterDetectionsPersistance (liste, n_max, element,latence)

% Ce filtre juge le critère:
%   - si le candidat à l'image N est proche spatialement de candidats des
%   images précédentes (de N - latence à N - 1).
%   Cela permet d'éliminer les éléments clignotant (car un feux est fixe au
%   rouge), et les éléments mouvants sur les bords de la vision: en effet
%   ils défilent rapidement sur les côtés, tandis qu'un feux de face reste
%   sensiblement dans la même zone.
%
% Ainsi, on range les candidats dans une liste de candidats sur les
% dernieres images ( cf valeur de latence).
% La liste est telle que:
%       liste[ img1[ max1[x,y], n_max fois... ] , img2[max1[x,y], ...n_max
%       fois ], ... sur 5 images.
% Pour être considérée comme persistante, les coordonnées doivent être
% dans une box autour des coordonnées de au moins 0.8*latence images
% précédentes.


epsilon=40; % critère de proximité spatiale en pixels
% ce critère est choisi arbitrairement par optimisation sur la vidéo de
% travail suite à notre visionnage. Cependant, il mériterait d'être adapté 
% selon la vitesse du véhicule. 
cpt=0;
% on va parcourir chacun des candidats de chacun des latence images
% dernières et voir si notre candidat est proche de l'un d'eux.
for i = 1:latence
    for j=1:n_max
        % on rejete les 0, c'est à dire les candidats refusés par les
        % filtres précédents
        if liste(i,j,1)>0
            % On regarde la distance entre les deux points, et on voit 
            % s'ils sont arbitrairement proches
            distx = abs( liste(i,j,1) - element(1) );
            disty = abs( liste(i,j,2) - element(2) );
            if  distx < epsilon
                %correspond à l'image i et au candidat_max j
                if disty < epsilon
                    cpt=cpt+1;
                end
            end
        end
    end
end
if cpt>=0.8*latence
    % il faut avoir été dans au moins sur les 0.8*latence images précédentes
    x=element(1);
    y=element(2);
else
    % on affiche les faux positifs pour vérifier le comportement du filtre
    rectangle('Position',[element(2),element(1),5,5],'EdgeColor', 'y','LineWidth',2)
    x=0;
    y=0;
end
end