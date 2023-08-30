function []=tracage_rectangle(x_approve,y_approve, l_box)
% seuil permettant de filtrer les faibles valeurs
w_rect=2*l_box; % largeur rectangle affichage
h_rect=2*l_box; % hauteur rectangle affichage
b=x_approve-w_rect/2; %centre le rectangle
a=y_approve-h_rect/2; % centre le rectangle
rectangle('Position',[y_approve-l_box,x_approve-l_box,w_rect,h_rect],'EdgeColor', 'r','LineWidth',1)  
end
