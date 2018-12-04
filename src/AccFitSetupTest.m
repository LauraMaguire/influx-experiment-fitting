function [fits] = AccFitSetupTest(time, acc, tauD, Ntrials, Nterms,cutoff)
    fits.c0 = zeros(Ntrials,2); % amplitude
    fits.D = zeros(Ntrials,2); % lifetime
    fits.c1 = zeros(Ntrials,2);
    fits.T1 = zeros(Ntrials,2);
    fits.adjrsquare = zeros(Ntrials,2);
    for n=1:Ntrials % loop over all trials
        if isnan(tauD(n))
            disp(['Skipping experiment ' num2str(n) ' of ' num2str(Ntrials) '.']);
        else
            disp(cutoff(n));
        [fitresult, gofcur] = sqrtFit((time{n}(1:cutoff(n))-time{n}(1)),acc{n,1}(1:cutoff(n))-acc{n,1}(1),tauD(n)); % green data first
        fits.c0(n,1) = fitresult.c0;
        fits.D(n,1) = fitresult.D;
%         fits.c1(n,1) = fitresult.c1;
%         fits.T1(n,1) = fitresult.T1;
        fits.adjrsquare(n,1) = gofcur.adjrsquare;
    
        [fitresult, gofcur] = sqrtFit((time{n}(1:cutoff(n))-time{n}(1)),acc{n,2}(1:cutoff(n))-acc{n,2}(1),tauD(n)); % red data second
        fits.c0(n,2) = fitresult.c0;
        fits.D(n,2) = fitresult.D;
%         fits.c1(n,2) = fitresult.c1;
%         fits.T1(n,2) = fitresult.T1;
        fits.adjrsquare(n,2) = gofcur.adjrsquare;
        disp(['Fit ' num2str(n) ' of ' num2str(Ntrials) '.']);
        end
    end
    disp('Finished fitting accumulation data.');
end