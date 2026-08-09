def title_case(text)
  text.split(" ").map(&:capitalize).join(" ")
end
