function result = RombergIntegration(a, b)
    f = @(x) 1500*log(1.5*10^5/(1.5*10^5-2300*x))-9.81*x;
    I = zeros(4, 4);
    
    n = 1;
    I(1, 1) = Trap(n, a, b, f);

    for iter = 2:4
        n = 2^(iter-1);
        I(iter, 1) = Trap(n, a, b, f);
        
        for k = 2:iter
            j = 2 + iter - k;
            I(iter, k) = (4^(k-1) * I(iter, k-1) - I(iter-1, k-1)) / (4^(k-1) - 1);
            
        end
    end

    result = I(4, 4);
end

function result = Trap(n, a, b, f)
    h = (b - a) / n;
    result = 0;
    for i = 1:n
        x0 = a + (i - 1) * h;
        x1 = a + i * h;
        result = result + (f(x0) + f(x1)) / 2 * h;
    end
end