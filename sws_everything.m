clear all
clc

load('contours2.mat')
contourN=length(contours);

cellID=zeros(contourN,1);

cellCentroid=zeros(contourN,2);

cellArea=zeros(contourN,1);
cellPeri=zeros(contourN,1);
cellSI=zeros(contourN,1);

MajorAxisL=zeros(contourN,1);
MinorAxisL=zeros(contourN,1);
cellAR=zeros(contourN,1);

cellOrientation=zeros(contourN,1);

I=imread('Figure_2-crop1.tif');
sz=size(I);

SI_colorcoded=zeros(sz(1),sz(2));

for k=1:contourN
    A=contours(k);
    B=cell2mat(A);
    if k~=7:12
    plot(B(:,2), B(:,1), 'k-', 'LineWidth', 1)
    C(:,:,k)=poly2mask(B(:,2),B(:,1),sz(1),sz(2));
    stats=regionprops(C(:,:,k),'Centroid','Area','Perimeter','MajorAxisLength','MinorAxisLength','Orientation');
    
    cellID(k,1)=k;

    cellCentroid(k,1:2)=stats.Centroid;

    cellPeri(k,1)=stats.Perimeter;
    cellArea(k,1)=stats.Area;
    cellSI(k,1)=cellPeri(k,1)/sqrt(cellArea(k,1));
    SI_colorcoded=SI_colorcoded+C(:,:,k)*cellSI(k,1);
    
    MajorAxisL(k,1)=stats.MajorAxisLength;
    MinorAxisL(k,1)=stats.MinorAxisLength;
    cellAR(k,1)=MajorAxisL(k,1)/MinorAxisL(k,1);
    
    cellOrientation(k,1)=stats.Orientation;

    else
        SI_colorcoded=SI_colorcoded;
    end
    
end


T=table([cellID],[cellCentroid],[cellPeri],[cellArea],[cellSI],[MajorAxisL],[MinorAxisL],[cellAR],[cellOrientation]);
tableName=['exp1756_C2_s1_channel 3_shape analysis_n7-12.xlsx'];
writetable(T,tableName);

figure, imshow(SI_colorcoded), hold on
set(gca,'DataAspectRatio',[1 1 1])

myColorMap = jet(256);
myColorMap(1, :) = [1 1 1]; % background -> white
colormap(myColorMap)
caxis([0 8])
colorbar

F=getframe(gca);
imwrite(F.cdata, 'sws_SI2.jpg');
% polarhistogram('BinEdges',[-pi/2 -pi/4 0 pi/4 pi/2],'BinCounts',[5 3 4 6])