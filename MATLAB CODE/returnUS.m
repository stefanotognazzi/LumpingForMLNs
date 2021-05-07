function [us_str] = returnUS ( str_stato )

    stato = char(str_stato);
    stato(1) = 'u';
    stato(2) = 's';

    us_str = string(stato);


end