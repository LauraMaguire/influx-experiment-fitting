function [fits] = AccFitSetup(time, acc, tauD, Ntrials)
    fits.amp = zeros(Ntrials,2); % amplitude
    fits.D = zeros(Ntrials,2); % lifetime
    fits.gof = cell(Ntrials,2); % offset
    for n=1:Ntrials % loop over all trials
        if isnan(tauD(n))
            disp(['Skipping experiment ' num2str(n) ' of ' num2str(Ntrials) '.']);
        else
        [fitresult, gofcur] = accFitShortTime(time{n}-time{n}(1),acc{n,1}-acc{n,1}(1),tauD(n)); % green data first
        fits.amp(n,1) = fitresult.A;
        fits.D(n,1) = fitresult.D;
        fits.gof{n,1} = gofcur;
    
        [fitresult, gofcur] = accFitShortTime(time{n}-time{n}(1),acc{n,2}-acc{n,2}(1),tauD(n)); % red data second
        fits.amp(n,2) = fitresult.A;
        fits.D(n,2) = fitresult.D;
        fits.gof{n,2} = gofcur;
        disp(['Fit ' num2str(n) ' of ' num2str(Ntrials) '.']);
        end
    end
    disp('Finished fitting accumulation data.');
end