Get %r{/services/search_results\.json\?q=([^&]+)$} do |search_string|
  Dupe.find(:albums) {|a| [a.title, a.artist].join(' ').downcase.include? search_string.downcase}
end
