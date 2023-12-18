function [p2] = apply_homography(p1, H)

p1_homo = [p1, 1];                               % cartesian -> homogeneous coord.
p2_homo = H * p1_homo';                          % multiply the homography matrix H
p2_homo = p2_homo';                              % column vector -> row vector
p2 = [p2_homo(1), p2_homo(2)] ./ p2_homo(3);     % homogenous -> cartesian coord. (elementwisely divide elements by w)
end