clear
clc

x        = 1:150;
my_time  = ones(length(x),1);
mat_time = my_time;

figure
title('My function in Cyan, Matlab in Green')
hold on 
for n = 1:length(x)
	tic
	my_fac(x(n));
	my_time(n) = toc;

	tic 
	factorial(x(n));
	mat_time(n) = toc;

	my_cum_time = cumsum(my_time(1:n));
	ma_cum_time = cumsum(mat_time(1:n));

	plot(1:n, my_cum_time,'-o','Color','cyan')
	plot(1:n, ma_cum_time,'-s','Color','green')

	text(n,(my_cum_time(n)+ma_cum_time(n))/2, num2str(my_fac(x(n))))
    
    pause(0.5)
end
