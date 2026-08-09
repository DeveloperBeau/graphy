def from_codes(codes)
  codes.map { |c| (c % 256).chr }.join
end
