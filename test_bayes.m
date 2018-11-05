X=csvread('X_train.csv');
y=csvread('label_train.csv');
x_star=csvread('X_test.csv');
y_star=csvread('label_test.csv');
k=find(y==1);
[z,d]=size(X)
whole=1:z;
s=setdiff(whole,k);
xone=X(k,:);%classify the training labels
xzero=X(s,:);

[n,~]=size(y_star);
y_predicted=zeros(n,1);
y_predicted_pro=zeros(n,1);
for i=1:n
    if i==51
        i
    end
    [y_predicted(i),y_predicted_pro(i)]=Naive_Bayes_Classifier(x_star(i,:),X,y,xone,xzero);
end

l=find(y_predicted==y_star)
correct=size(l)%total true predictions
whole=1:n
q=setdiff(whole,l)
xfalse=find(y_predicted(q))%false positive
xtrue=find(y_predicted(l))%true positive
xpositive=find(y_predicted)%total positive
csvwrite('result.csv',y_predicted)

%calculate the expectation for lambda1 and lambda2
k=find(y==1);
[z,d]=size(X)
whole=1:z;
s=setdiff(whole,k);
[N,~]=size(k)
[~,M]=size(s)
Elambda1=(sum(xone, 1)+ones(1,d))./(N+1)
Elambda0=(sum(xzero, 1)+ones(1,d))./(M+1)
misclassified=q(1:3)
email=x_star(misclassified,:)
axis=1:d;

for i=1:3
    plot(axis,email(i,:),'-ok','DisplayName',sprintf('email %d',misclassified(i)))
    hold on
    legend('-DynamicLegend');
    xlim([1,54])
    ylim([0,40])
    hold on
    plot( axis,Elambda1,'m-*','DisplayName', 'E[lambda1]')
    hold on
    plot(axis, Elambda0, 'b-*', 'DisplayName', 'E[lambda0]')
    hold on
    title('Feature distribution: Misclassified three emails versus lambda1 and lambda0')
    xlabel('Features')
    ylabel('Occurrence')
    set(gca, 'XTick', axis) 
    xtickangle(60)
    set(gca,'XTickLabel',{'make','address','all','3d','our','over','remove','internet','order','mail','receive','will','people','report','addresses''free','business','email','you','credit','your','font','000','money','hp','hpl','george','650','lab','labs','telnet','857','data','415','85','technology','1999','parts','pm','direct','cs','meeting','original','project','re','edu','table','conference',';','(','[','!','$','#'})
    hold off
    figure()
end
ambiguous=0.5.*ones(n,1)
diff=abs(ambiguous-y_predicted_pro)
indices=zeros(1,3)
for i=1:3
  [minn,idx] = min(diff)
  diff(idx) = 1;
  indices(i)=idx;
end
for i=1:3
    plot(axis,x_star(indices(i),:),'-ok','DisplayName',sprintf('email %d',indices(i)))
    hold on
    pu=legend('-DynamicLegend');
    pu.Location='northwest';
    xlim([1,54])
    ylim([0,40])
    hold on
    plot( axis,Elambda1,'m-*','DisplayName', 'E[lambda1]')
    hold on
    plot(axis, Elambda0, 'b-*', 'DisplayName', 'E[lambda0]')
    hold on
    title('Feature distribution: Most ambiguous three emails versus lambda1 and lambda0')
    xlabel('Features')
    ylabel('Occurrence')
    set(gca,'XTick',axis)
    xtickangle(60)
    set(gca,'XTickLabel',{'make','address','all','3d','our','over','remove','internet','order','mail','receive','will','people','report','addresses''free','business','email','you','credit','your','font','000','money','hp','hpl','george','650','lab','labs','telnet','857','data','415','85','technology','1999','parts','pm','direct','cs','meeting','original','project','re','edu','table','conference',';','(','[','!','$','#'})
    hold off
    figure()
end