function [T,L] = RGB2RGYBImage_opt(frame)

% On a rajouté la luminosité en sortie afin de ne pas avoir à la
% recalculer.
% Permet de transformer une image RGB en une image LAB puis en RGYB de
% manière optimisée.

% Stocke la taille de l'image
T_size = size(frame);
% Transformation de la matrice image en vecteur
allpixels = reshape(frame, T_size(1)*T_size(2), T_size(3));
% Effectue la transformation de domaine
T_bis = RGB2LABImage(allpixels); 
% Effectue L*(a* + b*)
T_ter = T_bis(:,1).*(T_bis(:,2) + T_bis(:,3)); 
% Retransformation en matrice à 2 dimensions
L = reshape(T_bis(:,1), [T_size(1),T_size(2)]); 
% Retransformation en matrice à 2 dimensions
T = reshape(T_ter, [T_size(1),T_size(2)]); 
end

function lab = RGB2LABImage(rgb)
rgbl = RGBs2RGBLinearImage(rgb);
xyz = RGBLinear2XYZImage(rgbl);
lab = XYZ2LABImage(xyz);
end


function rgbl = RGBs2RGBLinearImage(rgb)
T = 0.04045;
rgbl = rgb.*(rgb<T)./12.92 + h(rgb.*(rgb>=T)); %permet de réduire le temps de calcul
end

function y=h(x) %fonction utilisée dans RGBs2RGBLinearImage
y = ((x+0.055)/1.055).^2.4;
end


function xyz = RGBLinear2XYZImage(rgbl)
M = [0.4124     0.3576      0.1805;
    0.2126      0.7152      0.0722;
    0.0193     0.1192      0.9505];
xyz = M*rgbl';
xyz = xyz';
end


function lab = XYZ2LABImage(xyz)
D65white = [0.9505     1       1.0890];
xyzn = xyz./D65white; % définit la valeur de référence
lab = [ [116.*f(xyzn(:,2))-16 , 500.*(f(xyzn(:,1))-f(xyzn(:,2)))] 200.*(f(xyzn(:,2))-f(xyzn(:,3)))];
end

function nonlinearity = f(t) % calcul la non-linéarité pour passer de XYZ à LAB
nonlinearity = (t.*(t>((6/29)^3))).^(1/3)+ (7.787*t+16/116).*(t<=((6/29)^3));
end





    