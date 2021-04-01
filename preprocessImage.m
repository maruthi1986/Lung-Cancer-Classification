 function Iout = preprocessImage(I)
                
               
        if size(I,3)~=3
            I = cat(3,I ,I, I);
        end
        
        % Resize the image as required for processing 
        Iout = imresize(I, [227 227]); 
 end