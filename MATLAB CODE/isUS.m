function [is_us] = isUS( str_stato )

    stato = char( str_stato );
    if stato(1)=='u' && stato(2)=='s'
        is_us = true;
    else
        is_us = false;
    end    
       


end