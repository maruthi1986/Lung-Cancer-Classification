% This procedure loads a sequence of images
%
% Arguments:
%   'path', refers to a directory which contains a sequence of JPEG or PPM
%   images
%   'reduce' is an optional parameter that controls downsampling, e.g., reduce = .5
%   downsamples all images by a factor of 2.


function I = load_images(path, reduce)

    if ~exist('reduce')
        reduce = 1;
    end

    if (reduce > 1 || reduce <= 0)
        error('reduce must fulfill: 0 < reduce <= 1');
    end

    % find all JPEG or PPM files in directory
    files =  dir(path);
    files(1:2)=[];
    N = length(files);
    if (N == 0)
        files = dir([path '/*.ppm']);
        N = length(files);
        if (N == 0)
            error('no files found');
        end
    end

    % allocate memory
    sz = [227 227];
    r = floor(sz(1)*reduce);
    c = floor(sz(2)*reduce);
    I = zeros(r,c,3,N);

    % read all files
    for i = 1:N

        % load image
        if(contains(files(i).name,'.ini'))
            disp('ini Found');
            continue;
        end
        if(contains(files(i).name,'.svg'))
            disp('svg Found');
            continue;
        end
        disp(files(i).name);
        filename = [path '/' files(i).name];

        im = double(imread(filename)) / 255;
        im = preprocessImage(im);
        if (size(im,1) ~= sz(1) || size(im,2) ~= sz(2))
            error('images must all have the same size');
        end

        % optional downsampling step
        if (reduce < 1)
            im = imresize(im,[r c],'bicubic');
        end

        I(:,:,:,i) = im;
    end
end
