function [XL,XR] = build3Dmodel_autoCal(image01points, image02points, projector, camera)
% This function reconstructs the 3D point cloud of projector/camera
% correspondences with parameters obtained from auto-calibration. For
% 3D reconstruction using manual calibration see build3Dmodel_manualdata
% =========================================================================
% INPUT
% image01points, image02points: Nx2 (x,y) corresponding points in image 1 and image 2
% projector, camera : camera objects

% OUTPUT
% XL, XR : 3xN 3D points in point cloud from left/right camera reference
% =========================================================================

%% Setup
fc_left = [projector.intrinsic(1,1) projector.intrinsic(2,2)]';
cc_left = [projector.intrinsic(1,3) projector.intrinsic(2,3)]';
alpha_c_left = 0;
fc_right = [camera.intrinsic(1,1) camera.intrinsic(2,2)]';
cc_right = [camera.intrinsic(1,3) camera.intrinsic(2,3)]';
alpha_c_right = 0;
wp = projector.width;
wc = camera.width;
R = camera.extrinsic(:,1:3);
t = camera.extrinsic(:,4);

%% Normalize and undistort points
if strcmp(projector.distortionModel,'div')
    p1_i = [cc_left/wp;1];
    xy1n=[image01points/wp;ones(1,size(image01points,2))];
    [x1d_norm, T1] = normalise2dpts(xy1n);
    p1_norm = T1*p1_i;
    x1u_norm = undistortPoints(x1d_norm,p1_norm(1),p1_norm(2),projector.distortion);
    x1u = T1\[x1u_norm; ones(1,size(x1u_norm,2))];
    xL = x1u*wp;
    kc_left = 0;
else
    xL = image01points;
    kc_left = projector.distortion;
end
if strcmp(camera.distortionModel,'div')
    p2_i = [cc_right/wc;1];
    xy2n=[image02points/wc;ones(1,size(image01points,2))];
    [x2d_norm, T2] = normalise2dpts(xy2n);
    p2_norm = T2*p2_i;
    x2u_norm = undistortPoints(x2d_norm,p2_norm(1),p2_norm(2),camera.distortion);
    x2u = T2\[x2u_norm; ones(1,size(x2u_norm,2))];
    xR = x2u*wc;
    kc_right = 0;
else 
    xR = image02points;
    kc_right = camera.distortion;
end

%% Triangulation
om = rodrigues(R);
[XL,XR] = stereo_triangulation(xL,xR,om,t,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);
% dist_mse = fitPlaneToPoints(XL)

end