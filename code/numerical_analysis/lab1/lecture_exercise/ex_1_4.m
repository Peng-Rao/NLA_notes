% Code A
xA = 0;
iterA=0;
while (xA ~= 1)
	xA = xA + 1/16
 iterA=iterA+1
end

% Code B
%I have inserted a counter to end the infine loop
xB = 0;
iterB=0;
while (xB ~= 1 && iterB<100)
    xB = xB + 0.1
  iterB=iterB+1;
end

%% How is it possible to fix code B?
xC = 0;
iterC=0;
while (abs(xC-1) >= 2*eps)  

xC = xC + 0.1
  iterC=iterC+1
end

