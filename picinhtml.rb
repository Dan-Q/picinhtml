#!/usr/bin/ruby
unless $*.length == 2
  puts "Syntax: ./picinhtml.rb image-file text-file" and exit
end

%w{rubygems RMagick sha1}.each do |gem|
  begin
    require gem
  rescue LoadError => e
    puts "#{gem} gem required. Please install and try again." and exit
  end
end
include Magick

text = File::read($*[1]).gsub(/[\n\t]/, ' ').gsub('  ', ' ').strip
text_pos = -1

salt = SHA1::hexdigest("#{Time::now.to_s}#{text}")

colors, content = {}, ''
image = Image::read($*[0]).first
image.rows.times do |y|
  content << "<div class=\"line\">"
  image.columns.times do |x|
    px = image.pixel_color(x, y)
    red, green, blue = (px.red / 256).floor, (px.green / 256).floor, (px.blue / 256).floor
    hash = SHA1::hexdigest("#{salt}-#{red}-#{green}-#{blue}")[0,16]
    colors[hash] = "color: rgb(#{red}, #{green}, #{blue}); background: rgb(#{red}, #{green}, #{blue});"
    content << "<span class=\"c#{hash}\">#{text[text_pos += 1, 1]}</span>"
  end
  content << "</div>"
end
style = ".picinhtml { white-space: pre; font-family: monospace; font-size: 10px; line-height: 10px; }"
style << colors.collect { |key, value| ".picinhtml .c#{key}::selection { #{value} }\n.picinhtml .c#{key}::-moz-selection { #{value} }" }.join("\n")

puts "<!DOCTYPE html>\n<html><head>\n<title>#{$*[0]}</title>\n<style type=\"text/css\" media=\"screen\">\n#{style}\n</style>\n</head><body><div class=\"picinhtml\">#{content}</div></body></html>"
