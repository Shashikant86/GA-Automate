def ga_pushes
  ga_pushes = []
  all('#google-analytics-debug li').each do |li|
    ga_pushes << JSON.parse(li.text)
  end
  ga_pushes
end
