function [val] = fib(n)
if n <= 2
    val = 1;    % return val = 1 if n <= 2
    return
else
    val = fib(n-1) + fib(n-2);  % recursively call fib() function
end
