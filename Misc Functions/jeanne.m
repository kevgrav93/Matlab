fun=@(x,y) (9.81*1030).*(0.899-0.899*cos(x)).*(-((sin(x).^2).*cos(y)));
q=integral2(fun,0,2*pi,0,2*pi);