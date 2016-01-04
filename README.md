#Unsong Web Serial Scraper for Kindle

I adapted a [Worm Web Serial scaper](https://github.com/rhelsing/worm_scraper) to make a ebook/kindle version of Unsong, by Scott Alexander. You can now enjoy Unsong without all of the eye strain!

![Unsong Header](http://i.imgur.com/d9LvKMc.png)

##Download

Download the ebook or run the scraper yourself.

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
ruby unsong_scraper.rb > unsong.html
```

4. Convert (requires Calibre CLI)

```command
ebook-convert unsong.html unsong.mobi --authors "Scott Alexander" --title "Unsong" --max-toc-links 500
```
