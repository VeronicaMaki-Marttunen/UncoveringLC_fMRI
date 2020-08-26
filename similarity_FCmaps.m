% AUTHOR        Veronica Maki-Marttunen
% CONTACT       makimarttunen.veronica@gmail.com
% DATE          August 2020
% MATLAB        R2019b
% Code shared with publication Uncovering the locus coeruleus
% 2020

% Example code to calculate similarity between the functional connectivity maps of two different seeds
% Controlling for the map of a third (control) seed.
% Notice that the brainstem is excluded from the calculation (brainstem_mask.nii)

Nsubj = 100; % N subjects

I = spm_vol('\\path\to\data\brainstem_mask\brainstem_for_masking.nii');
brainstem_mask = spm_read_vols(I);
brainstem_mask = abs(brainstem_mask-1);

% Stand on directory with FC maps
% In CONN toolbox the directory is:
% conn_project\results\firstlevel\ANALYSIS_01

for subj = 1:9
    
   I =  spm_vol(['BETA_Subject00',num2str(subj),'_Condition001_Source001.nii']); % FC map corresponding to seed 1
   I2 = spm_read_vols(I);
   I2 = I2.*brainstem_mask;
   I2_reshape =reshape(I2, 1,size(I2,1)*size(I2,2)*size(I2,3));
   I2_reshape_resample = I2_reshape(1:100:end);
   
   I =  spm_vol(['BETA_Subject00',num2str(subj),'_Condition001_Source002.nii']); % FC map corresponding to seed 2
   I3 = spm_read_vols(I);
   I3 = I3.*brainstem_mask;
   I3_reshape = reshape(I3, 1,size(I3,1)*size(I3,2)*size(I3,3));
   I3_reshape_resample = I3_reshape(1:100:end);
   
   I =  spm_vol(['BETA_Subject',num2str(subj),'_Condition001_Source003.nii']); % FC map corresponding to control seed, e.g. PT
   I4 = spm_read_vols(I); 
   I4 = I4.*brainstem_mask;
   I4_reshape = reshape(I4, 1,size(I4,1)*size(I4,2)*size(I4,3));
   I4_reshape_resample = I4_reshape(1:100:end);
   
   c = corr([I2_reshape_resample',I3_reshape_resample'],I4_reshape_resample');
   Corr_source2_source3(subj) = c(2);
  
   clear I2* I3* I4*
end

for subj = 10:Nsubj
    
   I =  spm_vol(['BETA_Subject0',num2str(subj),'_Condition001_Source001.nii']); % FC map corresponding to seed 1
   I2 = spm_read_vols(I);
   I2 = I2.*brainstem_mask;
   I2_reshape =reshape(I2, 1,size(I2,1)*size(I2,2)*size(I2,3));
   I2_reshape_resample = I2_reshape(1:100:end);
   
   I =  spm_vol(['BETA_Subject0',num2str(subj),'_Condition001_Source002.nii']); % FC map corresponding to seed 2
   I3 = spm_read_vols(I);
   I3 = I3.*brainstem_mask;
   I3_reshape = reshape(I3, 1,size(I3,1)*size(I3,2)*size(I3,3));
   I3_reshape_resample = I3_reshape(1:100:end);
   
   I =  spm_vol(['BETA_Subject',num2str(subj),'_Condition001_Source010.nii']); % FC map corresponding to control seed, e.g. PT
   I4 = spm_read_vols(I); 
   I4 = I4.*brainstem_mask;
   I4_reshape = reshape(I4, 1,size(I4,1)*size(I4,2)*size(I4,3));
   I4_reshape_resample = I4_reshape(1:100:end);
  
   c = corr([I2_reshape_resample',I3_reshape_resample'],I4_reshape_resample');
   Corr_source2_source3(subj) = c(2);
     
   clear I2* I3* I4*
end