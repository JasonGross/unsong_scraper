#Worm Web Serial Scraper for Kindle

I couldn't find a good ebook/kindle version of worm, the fantastic web serial by wildbow (John McCrae), so I decided to make one. You can now enjoy worm without all of the eye strain! Until wildbow gets this thing published, this is the next best option.

[Please support the author!](http://parahumans.wordpress.com/donate/)

![Worm Header](http://parahumans.files.wordpress.com/2011/06/cityscape2.jpg)

##Download

Download in the format of your choice or run it yourself.

##How to run:

1. Clone this project
2. Install dependencies

```command
gem install uri
gem install open-uri
gem install nokogiri
```

3. Run the script and output into html file

```command
ruby worm_scraper.rb > worm.html
```

4. Convert with Calibre (requires install)

```command
ebook-convert worm.html worm.mobi
```