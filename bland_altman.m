% Code shared by Veronica Maki-Marttunen with publication Uncovering the LC
% 2020

P= {'\\path\to\data\rest\Seed1\corr_0001.img';'\\path\to\data\wmcsf_mask_nan_bin.nii'};
Q = ['Seed1_masked.nii'];
f = ['(i1.*i2)'];
flags = {[],[],[],[]};
Q = spm_imcalc_ui(P,Q,f,flags);

P= {'\\path\to\data\rest\Seed2\corr_0001.img';'\\path\to\data\wmcsf_mask_nan_bin.nii'};
Q = ['Seed2_masked.nii'];
f = ['(i1.*i2)'];
flags = {[],[],[],[]};
Q = spm_imcalc_ui(P,Q,f,flags);

I = spm_vol('Seed1_masked.nii');
data1_img = spm_read_vols(I);
I = spm_vol('Seed2_masked.nii');
data2_img = spm_read_vols(I);

figure

mean_data = mean([data1_img(:), data2_img(:)]');
diff = data1_img(:) - data2_img(:); % Difference between data1 and data2
diff = diff';
[a, b] = find(mean_data);

scatter(mean_data(b),diff(b))
xlim([-0.5 1])
ylim([-0.6 0.6])
xlabel('Average of T-statistics')
ylabel('Difference of T-statistics')
title('Seed2 - Seed1')