function out = gaussian(x,mu,sigma)
out = exp(-((x-mu)*(x-mu)')/(2*(sigma.^2)));
end