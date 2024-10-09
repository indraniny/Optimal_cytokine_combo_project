function plot_Rsq(Y,Y_prediction,lambda,RR_SQ,map,ERR)

figure()
set(gca,'FontSize',24) % Creates an axes and sets its FontSize to 18
    hold on;
    
    a=min(Y);
    b=max(Y);
    
    str = sprintf('map=%d\n lambda=%f\n R^2= %f\n SSR=%f\n',map,lambda,RR_SQ,ERR);
    txt = {str};
    
    text(a,b-3.2,txt,'FontSize',20)
    hold on
    plot(Y,Y_prediction,'g*',Y,Y,'b--','Linewidth',2,'MarkerSize',20);

    figure(2)
    bar(Y,Y_prediction)
    hold on;
    legend('Experiment','Prediction')
end