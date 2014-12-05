require 'nokogiri'
require 'open-uri'
require 'uri'

#set to first chapter
@next_chapter = 'http://parahumans.wordpress.com/category/stories-arcs-1-10/arc-1-gestation/1-01/'

while @next_chapter
  #check if url is weird
  if @next_chapter.to_s.include?("½")
    @next_chapter = URI.escape(@next_chapter)
  end
  doc = Nokogiri::HTML(open(@next_chapter))
  #get
  @chapter_title = doc.css('h1.entry-title').first #html formatted
  $stderr.puts @chapter_title.content
  @chapter_content = doc.css('div.entry-content').first #gsub first p
  #clean
  @chapter_content.search('.//div').remove
  @to_remove = doc.css('div.entry-content p').first #gsub first p
  @chapter_content = @chapter_content.to_s.gsub(@to_remove.to_s,"")
  #write
  puts @chapter_title
  puts @chapter_content
  #next
  @next_chapter = if doc.css('div.entry-content p a').last.content.to_s.include?("Next")
                    doc.css('div.entry-content p a').last['href']
                  else
                    false
                  end
end