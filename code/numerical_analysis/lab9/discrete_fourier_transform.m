function c=discrete_fourier_transform(xj,fxj,k)
    n=numel(k)-1;
    T = (1/(n+1)) * exp (-i .* (k * xj) );

    c = T * fxj;    

end