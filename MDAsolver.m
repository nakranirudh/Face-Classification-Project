function[facesMDA,datavisualise,mean0,scatterbetween,scatterwithin,priors,eigenvalues,eigenvectors,eigenvaluesdiag,eigenvectorstr]=MDAsolver(facestemp,mean,covar,numclasses)

[m,~]=size(mean);
[y,~]=size(covar);
priors=1/numclasses;
datavisualise=[];

mean0=zeros(size(mean(1,1)));
scatterwithin=zeros(size(covar(1).ClassCov));
scatterbetween=zeros(size(covar(1).ClassCov));

%Scatterwithin DONE
for i=1:y
    scatterwithin=scatterwithin+priors*covar(i).ClassCov;
end

%mu0 DONE
for i=1:m
    mean0=mean0+priors*mean(i,:);
end

%scatterbetween DONE
for i=1:m
    scatterbetween=scatterbetween+priors.*(mean(i,:)-mean0).'*(mean(i,:)-mean0);
end

newfacestemp=[];

for i=1:600
    newfacestemp(i,:)=reshape(facestemp(:,:,i),[1,504]);
end

% for i=1:
% 
%     testingarray(i,:)=testingsorted(i).Data.';
% 
% end

matrixcreated=pinv(scatterwithin)*scatterbetween;
[eigenvectors,eigenvalues]=eig(matrixcreated);
% eigenvaluesdiag=diag(abs(eigenvalues));
[eigenvalues, ind] = sort(eigenvalues,'descend');
eigenvectors = eigenvectors(:, ind);
eigenvaluesdiag=diag(abs(eigenvalues));
eigenvaluesdiag=eigenvaluesdiag(1:numclasses-1,:);
eigenvectorstr=eigenvectors(:,1:numclasses-1);
facesMDA=(newfacestemp*eigenvectorstr);


end

