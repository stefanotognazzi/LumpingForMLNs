function [as_str] = returnAS ( str_stato )

    stato = char(str_stato);
    stato(1) = 'a';
    stato(2) = 's';

    as_str = string(stato);


end