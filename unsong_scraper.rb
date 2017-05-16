# encoding: utf-8

require 'nokogiri'
require 'open-uri'
require 'uri'

@toc = "<h1>Table of Contents</h1>"
@book_body = ""
@index = -1

toc_page = Nokogiri::HTML(open('http://unsongbook.com/')).css('.pjgm-postcontent')

toc_page.css('a').each do |link|
  url = link['href']
  next unless url =~ /\/prologue|\/book|\/interlude|\/chapter/
  unless url.ascii_only?
    url = URI.escape(url)
  end
  if url.to_s.start_with?("//")
    url = "https:" + url
  end
  doc = Nokogiri::HTML(open(url))
  @chapter_title = doc.css('h1.pjgm-posttitle').first

  #modify chapter to have link
  @chapter_title_plain = @chapter_title.content
  $stderr.puts @chapter_title_plain
  @chapter_content = doc.css('div.pjgm-postcontent').first #gsub first p
  #clean
  @chapter_content.search('.//div').remove
  @to_remove = doc.css('div.entry-content p').first #gsub first p
  @chapter_content = @chapter_content.to_s.gsub(@to_remove.to_s,"")
  #write
  @book_body << "<h1 id=\"chap#{@index.to_s}\">#{@chapter_title_plain}</h1>"
  @book_body << @chapter_content
  @toc << "<a href=\"#chap#{@index.to_s}\">#{@chapter_title_plain}</a><br>"
  @index += 1
end

$stderr.puts "Writing Book..."

puts @toc
puts @book_body
