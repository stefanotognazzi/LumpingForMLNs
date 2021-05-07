function [is_as] = isAS( str_stato )

    stato = char( str_stato );
    if stato(1)=='a' && stato(2)=='s'
        is_as = true;
    else
        is_as = false;
    end    
       


end