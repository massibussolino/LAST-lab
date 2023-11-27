function [] = PlotEnvElements(Tenda1,Tenda2,Diorama,Floor)

% Tende nere, diorama grigio, pavimento a caso
[~,patchObj1] = show(Tenda1);
patchObj1.FaceColor = [ 0.4 0.4 0.4]; 

[~,patchObj2] = show(Tenda2);
patchObj2.FaceColor = [ 0.4 0.4 0.4];

[~,patchObj3] = show(Diorama);
patchObj3.FaceColor = [ 0.6 0.6 0.6];

[~,patchObj4] = show(Floor);
patchObj4.FaceColor = [ 0.901960784313726   0.694117647058824   0.458823529411765];



end

