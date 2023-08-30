function [frame] = filterDetectionCrop(frame, limite_detection_y)
% Un feu sera au moins perché à une certaine hauteur. Rien ne sert de
% traiter toute l'image (gain de temps et optimisation). 
frame=frame(1:limite_detection_y,:,:);
% On ne travaille que sur la partie supérieure de l'image car les feux se 
% trouvent à cette hauteur. La limite de limite_detection_y dépend de la 
% hauteur de la caméra. Il a été fixé arbitrairement suite à notre
% visionnage de la vidéo, mais mériterait d'être ajusté selon le modèle de
% la voiture et la position de la caméra. On pourrait envisager une limite
% dynamique. 
end

