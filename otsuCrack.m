function BW2 = otsuCrack(f)
%Recibe una imagen, lo convierte a escala de grises y encuentra grietas en
%la imagen.


if (ndims(f))>2
    g=rgb2gray(f);
end


%creamos una máscara sobel para aplicar el filtro sobre la imagen en gris
h=fspecial('sobel');
gsobel=imfilter(g,h);

%calculamos el umbral y activamos aquellos que estan por encima de dicho
%umbral mediante el metodo de otsu
level=graythresh(gsobel);
BW=im2bw(gsobel,level);

%luego etiquetamos las regiones calculamos el area de las regiones e
%identificamos las que sean mayores a 30
L=bwlabel(BW);
stats=regionprops(L,'Area');
allArea=[stats.Area];
idx=find([stats.Area]>30);
BW2=ismember(L,idx);