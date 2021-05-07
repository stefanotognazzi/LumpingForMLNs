function [is_ai] = isAI( str_stato )

    stato = char( str_stato );
    if stato(1)=='a' && stato(2)=='i'
        is_ai = true;
    else
        is_ai = false;
    end    
       


end