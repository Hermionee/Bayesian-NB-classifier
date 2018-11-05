function [y_star,y_pro1]=Naive_Bayes_Classifier(x_star,X,y,xone,xzero)
[n,d]=size(X);
[m,~]=size(xone);
p_y_star1_given_y=(1+m)/(n+2);
p_y_star0_given_y=1-p_y_star1_given_y;
p_x_star_given_xi1=0;
p_x_star_given_xi0=0;
for i=1:d
    xi=xone(:,i);
    xj=xzero(:,i);
    sumi=sum(xi);
    sumj=sum(xj);
    fac1=(sumi+1)*log(m+1);
    for j=1:(x_star(i)+sumi+1)
        fac1=fac1+log(j);
    end
    for j=1:(x_star(i))
        fac1=fac1-log(j);
    end
    fac1=fac1-(x_star(i)+sumi+1)*log(m+2);
    for j=1:(sumi+1)
        fac1=fac1-log(j);
    end
    
    fac0=(sumj+1)*log(n-m+1);
    for j=1:(x_star(i)+sumj+1)
        fac0=fac0+log(j);
    end
    for j=1:(x_star(i))
        fac0=fac0-log(j);
    end
    fac0=fac0-(x_star(i)+sumj+1)*log(n-m+2);
    for j=1:(sumj+1)
        fac0=fac0-log(j);
    end
    p_x_star_given_xi1=p_x_star_given_xi1+fac1
    p_x_star_given_xi0=p_x_star_given_xi0+fac0
    
end
y_star1=p_x_star_given_xi1+log(p_y_star1_given_y);
y_star0=p_x_star_given_xi0+log(p_y_star0_given_y);

if y_star1>y_star0
    y_star=1;
else
    y_star=0;
end

y_pro1=y_star1/(y_star0+y_star1)%the probability proportion of y being 1

end
