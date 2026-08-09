let is_digit_ch c = c >= '0' && c <= '9'

let is_alpha_ch c = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')

let is_space_ch c = c = ' ' || c = '\t'
