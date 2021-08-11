function EvaluarImagenes()
% Esta funcion toma las imagenes actuales y las segmentadas las convertimos
% a binarias y las pasamos a la función Evaluate obteniendo los valores de
% accuracy sensitivity specificity precision recall f_measure gmean
% pasandolos a un archivo excel


% Specify the folder where the files live.
readActFolder = 'C:\Users\usuario\Documents\JM\2021\Tesis\Concrete Crack Images for Classification\Positive BW';
% Specify the folder where the files live.
readSegFolder = 'C:\Users\usuario\Documents\JM\2021\Tesis\Concrete Crack Images for Classification\Otsu Segmentation';
% Check to make sure that folders actually exists.  Warn user if it doesn't.
if ~isfolder(readActFolder)
    errorMessage = sprintf('Error: la siguiente carpeta de lectura no existe:\n%s\nPor favor, especifique una nueva carpeta.', readActFolder);
    uiwait(warndlg(errorMessage));
    readActFolder = uigetdir(); % Ask for a new one.
    if readActFolder == 0
         % User clicked Cancel
         return;
    end
end
if ~isfolder(readSegFolder)
    errorMessage = sprintf('Error: la siguiente carpeta de destino no existe:\n%s\nPor favor, especifique una nueva carpeta.', readSegFolder);
    uiwait(warndlg(errorMessage));
    readSegFolder = uigetdir(); % Ask for a new one.
    if readSegFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.

actFilePattern = fullfile(readActFolder, '*.jpg'); % Change to whatever pattern you need.
segFilePattern = fullfile(readSegFolder, '*.jpg'); % Change to whatever pattern you need.
actTheFiles = dir(actFilePattern);
segTheFiles = dir(segFilePattern);

colum_header={'image_name','accuracy','sensitivity','specificity','precision','recall','f_measure','gmean'};
xlswrite('evaluaciones.xls',colum_header,'Sheet1','A1');


for k = 1 : length(actTheFiles)
   
    actBaseFileName = actTheFiles(k).name;
    actFullFileName = fullfile(actTheFiles(k).folder, actBaseFileName);
    actImageArray = imread(actFullFileName);
    
    segBaseFileName = segTheFiles(k).name;
    segFullFileName = fullfile(segTheFiles(k).folder, segBaseFileName);
    segImageArray = imread(segFullFileName);
    
    actBW=im2bw(actImageArray,0.5);
    segBw=im2bw(segImageArray,0.5);
    
    fprintf(1, 'Evaluando %s\n', actBaseFileName);
    
    ev=Evaluate(actBW,segBw);
    
    filaA=strcat('A',num2str((k+1),'%d'));
    filaB=strcat('B',num2str((k+1),'%d'));
    img_name = {actBaseFileName};
    xlswrite('evaluaciones.xls',img_name,'Sheet1',filaA);
    xlswrite('evaluaciones.xls',ev,'Sheet1',filaB);
end
