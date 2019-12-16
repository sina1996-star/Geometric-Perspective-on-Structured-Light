% Francis Li 
% November 11 2015
function success = save3D(cloud,filename,ext,type,denoise)
% This function is meant to save 3D data (point cloud) into various different formats.
% Currently calls Meshlab to save in the various formats. (VERY ROUND ABOUT
% AND INEFFICIENT WAY TO DO THIS!! ideally use Matlab functions).
% meshlabserver.exe and CloudCompare.exe need to be in search path.
% =========================================================================
% INPUT
% - cloud: (3xN) (x,y,z) 3D point cloud
% - filename: (string) name of file to be saved (without extension)
% - ext: (string) file extension. Supported: any cloud/mesh file that Meshlab
% and CloudCompare supports.
% - type: (string) 'cloud','mesh'. If 'mesh', will perform surface
% reconstruction with CloudCompare (more stable).
% - denoise: (boolean) option to perform noise removal on point cloud
% (will do it before mesh reconstruction if meshing)

% OUTPUT
% - success: (boolean) whether the 3D data was successfully saved or not.
% =========================================================================
% Note: Minimum checking is done to see if ext and type are compatible i.e.,
% trying to save a cloud as 'obj' may not work.

%% FUNCTION BEGIN
    % Check dimension of input cloud
    success = false;
    if 3 == size(cloud,1)
        points.vertex.x = cloud(1,:);
        points.vertex.y = cloud(2,:);
        points.vertex.z = cloud(3,:);
    elseif 3 == size(cloud,2)
        points.vertex.x = cloud(:,1);
        points.vertex.y = cloud(:,2);
        points.vertex.z = cloud(:,3);
    else
        disp('Input cloud needs to be (x,y,z) structure.');
        return;
    end
    if ~exist('denoise','var')
        denoise = false;
    end
    
    % Start with writing to a ply file in Matlab. (This is
    % inefficient. Leveraging Meshlab and CloudCompare as much as
    % possible).  
    plyFile = [filename,'.ply'];
    ply_write (points,plyFile);
    
    % Denoising
    if denoise
        % Call CloudCompare SOR
        ccCommand = ['CloudCompare.exe',' -SILENT', ' -AUTO_SAVE OFF',...
                     ' -O ', plyFile, ' -SOR 10 0.25', ...
                     ' -C_EXPORT_FMT PLY', ' -NO_TIMESTAMP ', '-SAVE_CLOUDS' ];
        ret = system(ccCommand);
        if ret ~= 0
            disp('Failed on calling CloudCompare for denoising.');
            return;
        end
        delete(plyFile);
        plyFile = [filename,'_SOR.ply']; % Automatically named...not sure how to change it in CloudCompare command line.
    end
    
    % Save to cloud
    if strcmp(type,'cloud')
        % Use Meshlab to convert to any format that Meshlab supports.
        if ~strcmp(ext,'ply')
            outFile = [filename,'.',ext];
            ret = system(['meshlabserver.exe',' -i ',plyFile,' -o ',outFile]);
            if ret ~= 0
                disp('Failed on calling Meshlab to save point cloud.');
                return;
            end
            delete(plyFile);
        end
        success = true;
        
    % Surface reconstruction and save to mesh
    elseif strcmp(type,'mesh')
        % Call CloudCompare for Delauney? triangulation
        ccCommand = ['CloudCompare.exe',' -SILENT', ' -AUTO_SAVE OFF', ...
                     ' -COMPUTE_NORMALS',' -O ', plyFile, ' -DELAUNAY -AA -MAX_EDGE_LENGTH 0.02', ...
                     ' -M_EXPORT_FMT ', ext, ' -NO_TIMESTAMP ', '-SAVE_MESHES' ];
        ret = system(ccCommand);
        if ret ~= 0
            disp('Failed on calling CloudCompare for surface reconstruction.');
            return;
        end
        if denoise
            outFile = [filename,'_SOR.',ext];
        else
            outFile = [filename,'.',ext];
        end
        % Apply Laplacian smooth with Meshlab
        smoothFilterFile = './_drivers/3Dreconstruction/surfaceReconstruction/filter_script_laplaciansmooth.mlx';
        system(['meshlabserver.exe',' -i ', outFile, ...
                ' -o ',[filename,'.',ext], ' -s ', smoothFilterFile ]);
        % Cleanup
        delete(plyFile);
        delete(outFile);
        success = true;
    else
        disp([type, ' type not supported (cloud or mesh only).']);
        return;
    end
    
% FUNCTION END
end