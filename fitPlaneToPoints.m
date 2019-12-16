function dist_mse = fitPlaneToPoints(XYZ)

numPoints = length(XYZ);
samples = uint32(linspace(1,numPoints, 0.5*numPoints));
samplePoints = XYZ(:,samples)';

% [~, mxIndices] = max(samplePoints);
% samplePoints(mxIndices,:) = [];


plane = fitPlane( samplePoints );
% axis([-50 50 -50 50 -50 50]);
% drawPlane3d(plane)
list = (distancePointPlane(samplePoints, plane)).^2;
dist_mse = sum(list);


pointsInPlane = projPointOnPlane(samplePoints, plane)';
R = 102/255;
G = 204/255;
B = 0;
colors = repmat([R G B], length(pointsInPlane), 1);
vrmlPoints(['3Dmesh_fittedplane.wrl'],pointsInPlane, colors);

end