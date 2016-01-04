#!/bin/bash

ruby unsong_scraper.rb > unsong.html || exit $?
ebook-convert unsong.html unsong.mobi --authors "Scott Alexander" --title "Unsong" --max-toc-links 500 || exit $?
