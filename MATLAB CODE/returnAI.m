function [ai_str] = returnAI ( str_stato )

    stato = char(str_stato);
    stato(1) = 'a';
    stato(2) = 'i';

    ai_str = string(stato);


end