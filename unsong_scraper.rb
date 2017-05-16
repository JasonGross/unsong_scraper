# encoding: utf-8

require 'nokogiri'
require 'open-uri'
require 'uri'
require 'parallel'

toc_page = Nokogiri::HTML(open('http://unsongbook.com/')).css('.pjgm-postcontent')

chapters = Parallel.map_with_index(toc_page.css('a'), :in_threads => 8) do |link, ind|
  index = ind - 1
  url = link['href']
  next unless url =~ /\/prologue|\/book|\/interlude|\/chapter/
  unless url.ascii_only?
    url = URI.escape(url)
  end
  if url.to_s.start_with?("//")
    url = "https:" + url
  end
  doc = Nokogiri::HTML(open(url))
  chapter_title = doc.css('h1.pjgm-posttitle').first

  #modify chapter to have link
  chapter_title_plain = chapter_title.content
  $stderr.puts chapter_title_plain
  chapter_content = doc.css('div.pjgm-postcontent').first #gsub first p
  #clean
  chapter_content.search('.//div').remove
  to_remove = doc.css('div.entry-content p').first #gsub first p
  chapter_content = chapter_content.to_s.gsub(to_remove.to_s,"")
  #write
  {"body" => "<h1 id=\"chap#{index.to_s}\">#{chapter_title_plain}</h1>" + chapter_content,
   "toc" => "<a href=\"#chap#{index.to_s}\">#{chapter_title_plain}</a><br>"}
end.select {|chapter| chapter}

@toc = "<h1>Table of Contents</h1>"
@book_body = ""

chapters.each do |chapter|
  @book_body << chapter["body"]
  @toc << chapter["toc"]
end

$stderr.puts "Writing Book..."

puts @toc
puts @book_body
