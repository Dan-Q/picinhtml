#!/usr/bin/ruby
unless $*.length == 3
  puts "Syntax: ./picinhtml.rb image-file text-file posterization-level" and exit
end

%w{rubygems RMagick}.each do |gem|
  begin
    require gem
  rescue LoadError => e
    puts "#{gem} gem required. Please install and try again." and exit
  end
end
include Magick

text = File::read($*[1]).gsub(/[\n\t]/, ' ').gsub('  ', ' ').strip
text_pos = -1

colors, content = {}, ''
image = Image::read($*[0]).first.posterize($*[2].to_i)
image.rows.times do |y|
  content << "<div class=\"line\">"
  image.columns.times do |x|
    px = image.pixel_color(x, y)
    red, green, blue = (px.red / 256).floor, (px.green / 256).floor, (px.blue / 256).floor
    css = "rgb(#{red},#{green},#{blue})"
    unless id = colors[css]
      id = colors.length
      colors[css] = id
    end
    content << "<span class=\"c#{id}\">#{text[text_pos += 1, 1]}</span>"
  end
  content << "</div>"
end
style = ".picinhtml { white-space: pre; font-family: monospace; font-size: 8px; line-height: 8px; letter-spacing: 2px; }\n"
colors = colors.invert
colors.length.times do |id|
  css = colors[id]
  style << ".picinhtml .c#{id}::selection {color:#{css};background:#{css}}\n"
  style << ".picinhtml .c#{id}::-moz-selection {color:#{css};background:#{css}}\n"
end

puts "<!DOCTYPE html>\n<html><head>\n<title>#{$*[0].gsub(/\..*?$/, '')}</title>\n<style type=\"text/css\" media=\"screen\">\n#{style}</style>\n</head><body><div class=\"picinhtml\">#{content}</div></body></html>"
