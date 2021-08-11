function SegmentarImagenes()
% Esta funcion toma las imagenes seleccionadas, segmenta las mismas
% mediante el metodo implementado OtsuCrack y las guarda en el directorio
% indicado en writeFolder
% Specify the folder where the files live.
readFolder = 'C:\Users\usuario\Documents\JM\2021\Tesis\Concrete Crack Images for Classification\Positive Selection';
% Specify the folder where the files live.
writeFolder = 'C:\Users\usuario\Documents\JM\2021\Tesis\Concrete Crack Images for Classification\Otsu Segmentation';
% Check to make sure that folders actually exists.  Warn user if it doesn't.
if ~isfolder(readFolder)
    errorMessage = sprintf('Error: la siguiente carpeta de lectura no existe:\n%s\nPor favor, especifique una nueva carpeta.', readFolder);
    uiwait(warndlg(errorMessage));
    readFolder = uigetdir(); % Ask for a new one.
    if readFolder == 0
         % User clicked Cancel
         return;
    end
end
if ~isfolder(writeFolder)
    errorMessage = sprintf('Error: la siguiente carpeta de destino no existe:\n%s\nPor favor, especifique una nueva carpeta.', writeFolder);
    uiwait(warndlg(errorMessage));
    writeFolder = uigetdir(); % Ask for a new one.
    if writeFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.

filePattern = fullfile(readFolder, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

for k = 1 : length(theFiles)
   
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    % such as reading it in as an image array with imread()
    imageArray = imread(fullFileName);
    n=strcat(writeFolder,'\',baseFileName);
    bw=otsuCrack(imageArray);
    imwrite (bw,n); 
    %imshow(imageArray);  % Display image.
    %drawnow; % Force display to update immediately.
end
