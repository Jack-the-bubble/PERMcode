clear all
% parametry kamery
f = 525;
cx = 312;
cy = 264;

D = double(imread('2019-06-11_10-31-30.066_d.png'));
rgb = imread('2019-06-11_10-31-30.066_c.png');

hsv = rgb2hsv(rgb);

XYZ = zeros(480, 640, 3);


for i = 1: 480
    for j = 1 : 640
%         if (hsv(i, j, 2) < 0.1) 
        XYZ(i, j, 3) = D(i, j);
        XYZ(i, j, 1) = (j - cx)*XYZ(i, j, 3)/f; %wyznaczanie wymiaru x
        XYZ(i, j, 2) = (i - cy)*XYZ(i, j, 3)/f; %wyznaczanie wymiaru y
%         end
    end
end
cloud = pointCloud(XYZ/1000, 'Color', hsv);

%  pcshow(cloud)

[fit, inlier, outlier] = pcfitplane(cloud,0.04);
plane1 = select(cloud, inlier);
remainCloud = select(cloud, outlier);
% pcshow(plane1)
% pcshow(remainCloud)

% vector_to_isolate = []
% for i = 1 : size(remainCloud.Location, 1)
%     if (remainCloud.Location(i, 3) < 1)
%         vector_to_isolate = [vector_to_isolate; i];
%     end
% end

% remainCloud = select(remainCloud, vector_to_isolate);
% pcshow(remainCloud)

vector_to_isolate = []
for i = 1 : size(remainCloud.Location, 1)
    if (remainCloud.Color(i, 3) > 230) && (remainCloud.Color(i, 2) <40) %&& (remainCloud.Color(i, 1) >20)
        vector_to_isolate = [vector_to_isolate; i];
    end
end
remainCloud = select(remainCloud, vector_to_isolate);
% pcshow(remainCloud)

roi = [0.1, 0.3, -0.2, 0.1, -inf, inf];
sampleIndices = findPointsInROI(remainCloud,roi);
cut_view = select(remainCloud, sampleIndices);
% pcshow(cut_view)
[spher, inlsph, outsph] = pcfitsphere(cut_view, 0.022);
cutSphere = select(cut_view, inlsph);
remainSphere = select(cut_view, outsph);
% [spher, inlsph, outsph] = pcfitsphere(remainCloud, 0.022);
% cutSphere = select(remainCloud, inlsph);
% remainSphere = select(remainCloud, outsph);

% pcshow(cutSphere);

pcshow(cloud);
hold on;
plot(spher);




