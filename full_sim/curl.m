function vflx = curl( stfn, stbc, parms, mats )

%Compute velocity flux from streamfunction.
%   Note: requires streamfunction from coarser grid on edge 
%         of current domain (stored in stbc) 

m = parms.m; n = parms.n;


%First get contribution without accounting for BCs:
vflx = mats.C * stfn;

%**Now for BCs

    %!!account for x-velocity block (requires terms on bottom 
    %  and top part of domain):

        %Bottom part

            %points that need to average coarser domain:
            vflx( 1:2:m-1 ) = vflx( 1:2:m-1 ) - ...
                stbc( 1:2:m-1 ) ;

            %points that don't need to average coarser domain:
            vflx( 2:2:m-2 ) = vflx( 2:2:m-2 ) - ...
                stbc( 2:2:m-2 );

        %Top part

            %indices for fine grid
            topf = (n-1)*(m-1) + (1 : m-1);
            
            topf(1:2:end)
            
            size( vflx )
            size( stbc )

            %points that need to average coarser domain:
            vflx( topf(1:2:end) ) = vflx( topf(1:2:end) ) + ...
                stbc( topf(1:2:end) );

            %points that don't need to average coarser domain:
            vflx( topf(2:2:end-1) ) = vflx( topf(2:2:end-1) ) + ...
                stbc( topf(2:2:end-1) );


    %!!    

    %!!y-velocity block

        %left part

            %indices for fine grid
            leftf = 1 : m : m*(n-2) + 1 ;

            %points that need to average coarser domain:
            vflx( leftf(1:2:end) ) = vflx( leftf(1:2:end) ) + ...
                stbc( leftf(1:2:end) ) ;

            %points that don't need to average coarser domain:
            vflx( leftf(2:2:end-1) ) = vflx( leftf(2:2:end-1) ) + ...
                stbc( leftf(2:2:end-1) );

        %right part

            %indices for fine grid
            rightf = m : m : m*(n-2) + m;

            %points that need to average coarser domain:
            vflx( rightf(1:2:end) ) = vflx( rightf(1:2:end) ) - ...
                stbc( rightf(1:2:end) );

            %points that don't need to average coarser domain:
            vflx( rightf(2:2:end-1) ) = vflx( rightf(2:2:end-1) ) - ...
                stbc( rightf(2:2:end-1) );

    %!!

%**

