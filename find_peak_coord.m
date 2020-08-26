% AUTHOR        Veronica Maki-Marttunen
% CONTACT       makimarttunen.veronica@gmail.com
% DATE          August 2020
% MATLAB        R2019b
% Code shared with publication Uncovering the locus coeruleus
% 2020

% Example code to find centre coordinate in individual masks
% Plot centre coordinates in scatter plot
% Plot centre coordinates on brain slices
% See Figure 8 of paper

% The directory should contain all the individual masks
% Script partly based on https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=spm;1201d1f6.1801

D=ls('Subj*'); % Prefix of the masks
cont = 0;
for subj = 1:length(D)
    cont = cont+1;
    V = spm_vol(D(subj,:));
    [dat,XYZmm] = spm_read_vols(V);
    [L,n] = spm_bwlabel(double(dat>0),26);
    for i=1:n
        coord(i,:) = mean(XYZmm(:,L==i),2);
    end
    peak_coord{cont} = coord; % store coordinate
    subject{cont} = D(subj,:); % store subject
end

% Scatter plot

peak_coord_all = peak_coord{1};
for i=2:length(peak_coord)
    temp = peak_coord{i};
    peak_coord_all(size(peak_coord_all,1)+1:size(peak_coord_all,1)+size(temp,1),:) = temp;
end

figure
plot3(peak_coord_all(:,1),peak_coord_all(:,2),peak_coord_all(:,3),'.')
hold on
plot3(mean(peak_coord_all(peak_coord_all(:,1)>0,1)),mean(peak_coord_all(peak_coord_all(:,1)>0,2)),mean(peak_coord_all(peak_coord_all(:,1)>0,3)),'o','markersize',10)
plot3(mean(peak_coord_all(peak_coord_all(:,1)<0,1)),mean(peak_coord_all(peak_coord_all(:,1)<0,2)),mean(peak_coord_all(peak_coord_all(:,1)<0,3)),'o','markersize',10)

% Brain slices

I=spm_vol('background_image.nii');
I2=spm_read_vols(I);
T=I.mat;
mni=peak_coord_all;
coordinate = [mni(:,1) mni(:,2) mni(:,3) ones(size(mni,1),1)]*(inv(T))';
coordinate(:,4) = [];
coordinate = round(coordinate);

unique_z = unique(coordinate(:,3));

% Generate one figure per brain slice and save in png format

for i=1:size(unique_z,1)
    coord2 = coordinate(coordinate(:,3)==unique_z(i),:);
    figure
    imagesc(I2(:,:,unique_z(i)))
    hold on
    plot(coord2(:,2),coord2(:,1),'r.','markersize',8)
    colormap('gray')
    saveas(gcf,['Slice',num2str(i),'.png'])
end