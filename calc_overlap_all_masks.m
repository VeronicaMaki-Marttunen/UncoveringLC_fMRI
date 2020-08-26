% AUTHOR        Veronica Maki-Marttunen
% CONTACT       makimarttunen.veronica@gmail.com
% DATE          August 2020
% MATLAB        R2019b
% Code shared with publication Uncovering the locus coeruleus
% 2020

% Example code to calculate ratio of overlap between two masks and save
% image with overlap of several masks
% Plot consensus mask on template (e.g. atlas) mask (Figure 7)

% The directory should contain binary masks in the same space

I = spm_vol('Seed1.nii');
S1 = spm_read_vols(I); 
% check that the read volumes are binary -if not, binarize first!
unique(S1)

I = spm_vol('Seed2.nii');
S2 = spm_read_vols(I);

I = spm_vol('Seed3.nii');
S3 = spm_read_vols(I);

I_S1_S2 =  S1 + S2;
I_S1_S3 =  S1 + S3;
I_S2_S3 =  S2 + S3;

% Ratio of overlap between two masks based on size of S1
(sum(sum(sum(I_S1_S2==2))))/(sum(sum(sum(S1))))

% Save image with overlap over all masks
Iall = S1 + S2 + S3;
I.fname = 'LCconsensus.nii';
spm_write_vol(I,Iall)


% Plot consensus mask over mask from Keren et al. 2009
% Masks should be in the same space!

figure
I = spm_vol('Atlas.nii'); % Keren et al. 2009
I2=spm_read_vols(I);
I2(I2==0)=NaN;
image3(I2)
hold on
I = spm_vol('LCconsensus.nii');
I2=spm_read_vols(I);
I2(I2==0)=NaN;
patch_3Darray(I2,[0 0 1],'col'); % needs function patch_3Darrary on MATLAB path

set(gca,'xtick',[34:2:44],'ytick',[36:1:40],'ztick',[20:2:26]);

% For the axis, you need to know the equivalent of axis coordinates into MNI.
% See http://www.alivelearn.net/?p=1434
% and specify T as:
% [Y,XYZ] = spm_read_vols(I); T=I.mat;

set(gca,'xticklabel',{' ','8','4','0','-4','-8'},'yticklabel',{'-42','-40','-38','-36',' '},'zticklabel',{'-32','-28','-24','-20'});

xlabel('x')
ylabel('y')
zlabel('z')