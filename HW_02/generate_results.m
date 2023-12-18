function contentAwareResize = generate_results(filename, reduceAmt, reduceWhat)
im = imread(filename);              % read image file

if strcmp(reduceWhat, 'HEIGHT')     % reduce HEIGHT
    for i = 1:reduceAmt
        if i == 1
            contentAwareResize = reduceHeight(im);    % first height reduction
        else
            contentAwareResize = reduceHeight(contentAwareResize);   % if not i==1, recursively use reduceHeight function, with contentAwareResize as an input
        end
    end
    
else                                % reduce WIDTH
    for i = 1:reduceAmt
        if i == 1
            contentAwareResize = reduceWidth(im);     % first width reduction
        else    
            contentAwareResize = reduceWidth(contentAwareResize);    % if not i==1, recursively use reduceWidth function, with contentAwareResize as an input
        end
    end

end

end