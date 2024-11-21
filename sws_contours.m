
clear all 
clc

I=imread('Figure_2-crop1.tif');
IND=rgb2ind(I,2048,'nodither');
sz=size(I);
contourN=0;
contourL=[];

for j=1:max(IND(:))
BW=(IND==j);     
[B,L]=bwboundaries(BW,'noholes');
for k=1:length(B)
   boundary=B{k};
   if length(boundary)>19
   plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 1)
   contourN=contourN+1;
   contours{contourN,:}=B{k};
   sz2=size(cell2mat(B));
   contourL(contourN,:)=sz2(1);
   end
end
end

bkgdID=max(contourL(:));
find(contourL==bkgdID)
contourN
save contours2.mat contours
