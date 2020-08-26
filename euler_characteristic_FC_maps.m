% AUTHOR        Veronica Maki-Marttunen
% CONTACT       makimarttunen.veronica@gmail.com
% DATE          August 2020
% MATLAB        R2019b
% Code shared with publication Uncovering the locus coeruleus
% 2020

% Example code to produce Euler Characteristic values between two functional connectivity maps
% Produce plots of EC and cluster count (Figure 12)
% Based on https://osf.io/xzbng/
% ds109_euler_chars.m 

base_dir = '\\path\to\FC_maps\rest';

FCmap_Seed1_stat_file = fullfile(base_dir, 'Seed1', 'spmT_0001.nii');
FCmap_Seed2_stat_file = fullfile(base_dir, 'Seed2', 'spmT_0001.nii');
% Can add more stat files
spm_mask = fullfile(base_dir, 'mask.nii');

euler_array = {FCmap_Seed1_stat_file, FCmap_Seed2_stat_file}; % concat the stat files
mask_array  = {spm_mask,      spm_mask};

% function euler_chars must be in MATLAB path
for i=1:length(euler_array)
	euler_chars(euler_array{i}, mask_array{i});
end


% Plots
dirs_FC = {'Seed1','Seed2'};
T = -4:0.005:10;
figure
subplot(2,1,1)
hold on

for i = 1:4
    cd(dirs_FC{i});
ec = load('euler_chars.csv');
plot(T,ec(:,2))
cd('..')
end

xlabel('T statistic')
ylabel('Euler Characteristic')
legend('Seed1','Seed2')

subplot(2,1,2)
hold on

for i = 1:4
    cd(dirs_FC{i});
cc = load('cluster_count.csv');
plot(T,cc(:,2))
cd('..')

end
xlabel('T statistic')
ylabel('cluster count')
legend('Seed1','Seed2')