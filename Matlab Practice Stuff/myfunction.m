function y = myfunction(x)
% Function of one argument with one return value

a = 42;              % Have a global variable of the same name

fprintf('The value of a in myfunction is: %s\n', num2str(a));

y = a + x;
