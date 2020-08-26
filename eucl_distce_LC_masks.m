% AUTHOR        Veronica Maki-Marttunen
% CONTACT       makimarttunen.veronica@gmail.com
% DATE          August 2020
% MATLAB        R2019b
% Code shared with publication Uncovering the locus coeruleus
% 2020

% Calculate euclidean distance between two centers of coordinates
% Plot peak coordinates (Figure 6)

%LC left
AT1 = [-3.7 -37 -24]; % peak coordinate reported in Keren et al. 2009, z = -24
AT2 = [-4.7 -37 -27]; % peak coordinate reported in Keren et al. 2009, z = -27
NM = [-4 -38 -26]; % peak coordinate group NM mask of current study

p1 = AT1; % or AT2
p2 = NM;
distance = sqrt( (p2(1)-p1(1)).^2 + (p2(2)-p1(2)).^2 + (p2(3)-p1(3)).^2)

%LC right
AT1 = [5.2 -37 -24]; % peak coordinate reported in Keren et al. 2009, z = -24
AT2 = [5.8 -37 -27]; % peak coordinate reported in Keren et al. 2009, z = -27
NM_new = [6 -38 -26]; % peak coordinate group NM mask of current study

p1 = AT1; % or AT2
p2 = NM;
distance = sqrt( (p2(1)-p1(1)).^2 + (p2(2)-p1(2)).^2 + (p2(3)-p1(3)).^2)

% Plot peak coordinates

shapestring = {'s','d','<','pentagram','o'};
figure

x = [5.2 5.8 6 4];
y = [-36.9 -37.2 -38 -38];
z = [-24 -27 -26 -29];
for i = 1:length(x)
plot3(x(i),y(i),z(i),'Color', 'k','Marker',shapestring{i},'markersize',10,'linestyle','none','linewidth',1.5)
hold on
end

x = [-3.7 -4.7 -4 -6 -6 ];
y = [-37 -37.3 -38 -38 -39];
z = [-24 -27 -26 -27 -30];
for i = 1:length(x)
plot3(x(i),y(i),z(i),'Color', 'k','Marker',shapestring{i},'markersize',10,'linestyle','none','linewidth',1.5)
hold on
end

% Coordinates from previous papers, all slices
% Keren et al. 2009, Dahl et al. 2019

xK = [-2.5 -3.1 -3.7 -4.7 -5.5 -6.9 4.1 4.6 5.2 5.8 6.4 7.6];  
yK = [-36.3 -36.7 -37.0 -37.3 -37.8 -38.6 -36.2 -36.6 -36.9 -37.2 -37.7 -38.5];
zK =  [-18 -21 -24 -27 -30 -33 -18 -21 -24 -27 -30 -33];

xD = [4 -3 4 -3 5 -3 5 5 -5];  
yD = [-36 -36 -36 -36 -36 -36 -37 -37 -38];
zD =  [-18 -18 -20 -20 -22 -22 -24 -26 -28];

plot3(xK,yK,zK,'Color', 'r','Marker','*','markersize',10,'linestyle','none')
hold on
plot3(xD,yD,zD,'Color', 'r','Marker','.','markersize',10,'linestyle','none')

xlim([-10 10])
ylim([-40 -35])
zlim([-34 -17])
grid on
xlabel('x')
ylabel('y')
zlabel('z')
legend('AT1 r','AT2 r','NM r','mICA r','AT1 l','AT2 l','NM l','mICA l', 'pupil','Keren et al. 2009','Dahl et al. 2019')
