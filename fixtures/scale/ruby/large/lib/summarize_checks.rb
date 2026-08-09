def summarize_checks(outcomes)
  good = outcomes.count { |_, ok| ok }
  "#{good}/#{outcomes.length} family checks passed"
end
