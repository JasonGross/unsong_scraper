# encoding: utf-8

require 'nokogiri'
require 'open-uri'
require 'uri'

#set to first chapter
@next_chapter = 'http://unsongbook.com/prologue-2/'
@toc = "<h1>Table of Contents</h1>"
@book_body = ""
@index = -1

while @next_chapter
  #check if url is weird
  if @next_chapter.to_s.include?("½")
    @next_chapter = URI.escape(@next_chapter)
  end
  if @next_chapter.to_s.start_with?("//")
    @next_chapter = "https:" + @next_chapter
  end
  doc = Nokogiri::HTML(open(@next_chapter))
  #get
  @chapter_title = doc.css('h1.pjgm-posttitle').first #html formatted

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
  #next
  @next_chapter = if doc.css('div.pjgm-navigation div a').last.content.to_s.include?("→")
                    doc.css('div.pjgm-navigation div a').last['href']
                  else
                    false
                  end
end

$stderr.puts "Writing Book..."

puts @toc
puts @book_body
