function [] = showImageAndResults(start,stop,path)

i=start;
%nombre d'image à partir duquel on considère la persistance
latence=5;
% nombre de maxima à calculer
n_max = 10;
%longueur de la box Size, pour éliminer des pixels autour d'un maximum
l_box = 10;
% seuil de détection du rouge
threshold = 5000;
%limite de la zone où on observe
limite_detection_y = 170;
% compteur de tour pour réinitialiser la liste des images persistantes
k=1;
% liste de sotckage des maximaux pour savoir s'ils sont persistants et
% fixes
liste=zeros(latence,n_max,2);
% boucle sur l'ensemble des images de la plage considérée
while i<stop
    
    number= sprintf("frame_%06d.jpg",i);
    path_t=sprintf('%s%s',path,number);
    set(gcf, 'Position', get(0, 'Screensize'));
    img=imread(path_t);
    imagesc(img) % affiche l'image
    % On réduit l'espace de travail sur l'image. En effet, un feu ne se
    % présentera pas en dessous d'une certaine hauteur. On optimise ainsi
    % le temps d'éxécution du programme en diminuant le nombre de pixels à
    % traiter. 
    img=filterDetectionCrop(img, limite_detection_y);
    [RGYB,L] = RGB2RGYBImage_opt(deformatImages(img));
    %imagesc(RGYB)
    % fait le calcul de maxima et on en récupère n_max dans une liste
    [x,y,maxValue] = detectMaxima(RGYB,n_max,l_box);
    % on filtre les maximums: s'ils sont inférieurs au seuil threshold, on
    % les mets à 0 dans la liste des candidats. La liste des candidats est
    % ainsi de taille fixe pour l'ensemble des filtres et de la procédure
    [x_approve,y_approve] = filterDetectionsThreshold(x,y,RGYB, threshold);
    % les candidats sont rangés dans la liste servant au filtre de
    % persistance.
    liste(k,:,1)=x_approve;
    liste(k,:,2)=y_approve;
    k=k+1;
    % la latence est fixée arbitrairement après plusieurs essais. Il s'agit
    % d'une limite à partir de laquelle le candidat est considérée comme
    % rémanent.
    if k>latence
        k=1; % on réinitialise la liste des candidats pour la persistance
    end
    % permet de visualiser l'espace de travail que l'on a réduit à une
    % partie de l'image seulement
    yline(limite_detection_y,'Color', 'y','Label',"surface détection");
    % on va vérifier chacun des candidats présent dans la liste des
    % candidats, c'est à dire les n_max candidats
    for j=1:n_max
        element=[x_approve(j),y_approve(j)];
        % filtre de rémanence du feux sur l'image
        [x_approve(j),y_approve(j)]=filterDetectionsPersistance(liste, n_max, element, latence);
        % filtre des caractéristiques matérielles et géométriques d'un feux
        % sur l'image
        [x_approve(j),y_approve(j)]=filterDetections_caracteristiques(x_approve(j),y_approve(j),L,RGYB);
        % les zeros de la listes sont persistants mais ne correspondent à 
        % aucun feux (ce sont les candidats qui ont échoués aux tests des 
        % filtres précédents) et on ne veut pas les afficher
        if x_approve(j)>0 
            if y_approve(j)>0
                % On trace un rectangle  rouge pour montrer qu'un feu a 
                % été repéré
                tracage_rectangle(x_approve(j),y_approve(j),l_box)
            end
        end
    end
    i=i+1;
    %permet d'avoir l'impression d'une vidéo, fixé à un peu plus de 120
    %FPS
    pause(0.001);  
end
% cette pause permet de se rendre compte de la fin de la vidéo, simple 
% confort de visionnage
pause(0.5);
close
end