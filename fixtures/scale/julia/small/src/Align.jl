module Align

export pad_left, pad_right, center_text

function pad_left(text::String, width::Int)
    return lpad(text, width)
end

function pad_right(text::String, width::Int)
    return rpad(text, width)
end

function center_text(text::String, width::Int)
    lead = div(width - length(text), 2) + length(text)
    return pad_left(text, lead)
end

end
