clear all
% parametry kamery
f = 525
cx = 312
cy = 264

D = double(imread('2019-06-11_10-31-30.066_d.png'));
rgb = imread('2019-06-11_10-31-30.066_c.png');

hsv = rgb2hsv(rgb);
 
% X = (x-cx)*Z/f

XYZ = zeros(480, 640, 3);

for i = 1: 480
    for j = 1 : 640
%         if hsv(i, j, 2) < 0.2
        XYZ(i, j, 3) = D(i, j);
        XYZ(i, j, 1) = (j - cx)*XYZ(i, j, 3)/f; %wyznaczanie wymiaru x
        XYZ(i, j, 2) = (i - cy)*XYZ(i, j, 3)/f; %wyznaczanie wymiaru y
%         end
    end
end

cloud = pointCloud(XYZ);

% pcshow(cloud)

[fit, inlier, outlier] = pcfitplane(cloud,40);
plane1 = select(cloud, inlier);
remainCloud = select(cloud, outlier);
% pcshow(plane1)
pcshow(remainCloud)

% roi = [-200, 50, -200, 100, -inf, inf];
roi = [-200, 400, -300, 500, -inf, inf];
sampleIndices = findPointsInROI(remainCloud,roi);
cut_view = select(remainCloud, sampleIndices)
pcshow(cut_view)
% roi = [0, 400, -200, 100, -inf, inf];
[spher, inlsph, outsph] = pcfitsphere(cut_view, 22)
%  [spher, inlsph, outsph] = pcfitsphere(remainCloud,22)
 cutSphere = select(cut_view, inlsph)
 remainSphere = select(cut_view, outsph)
 
 
pcshow(cutSphere)
% hold on 
R=1
[s_x, s_y, s_z] = sphere()
base_s(:, :, 1)=s_x*R;
base_s(:, :, 2)=s_y*R;
base_s(:, :, 3)=s_z*R;

s_cloud = pointCloud(base_s);
pcshow(s_cloud)

pcshow(remainSphere)

[spher2, inlsph2, outsph2] = pcfitsphere(remainSphere,22)
cutSphere2 = select(remainSphere, inlsph2)
pcshow(cutSphere2)
