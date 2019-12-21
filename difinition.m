camera.height=2048;
camera.width=2448;
camera.pprior=[1224,1024];
camera.fprior=4996.1;
camera.fNorm=3191.7;
camera.intrinsic=[2458.8,0,1222.7;0,2458.8,1026.1;0,0,3191.7];
camera.extrinsic=[0.8966,-0.0502,0.4399,-0.7523;-0.0056,0.9922,0.1247,-0.4315;-0.4427,-0.1142,0.8893,-0.4979];
camera.distortion=[-0.1002,0.1617,-0.0039,0.0103,0];
camera.distortionModel='poly';


projector.distortionModel='poly';
projector.height=1600;
projector.width=2560;
projector.pprior=[1402,519];
projector.fprior=3859.6;
projector.fNorm=3018.9;
projector.intrinsic=[4464.7,0,1402.1;0,4464.7,521.0558;0,0,3018.9];
projector.extrinsic=[1,0,0,0;0,1,0,0;0,0,1,0];
projector.distortion=[-0.0784,-0.3008,0.0364,0.0751,0];

save('camera.mat','camera');
save('projector.mat','projector');
