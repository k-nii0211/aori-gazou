require 'open-uri'
require 'nokogiri'
require 'fileutils'

root_url = 'http://blog.livedoor.jp/chihhylove'

doc = Nokogiri::HTML(open("#{root_url}/archives/8660418.html"))

local_dir = "#{File.dirname(__FILE__)}/../tmp"

FileUtils.mkdir_p(local_dir) unless File.exist?(local_dir)

doc.xpath('//*[@id="articlebody"]//img[@class="image pict"]/@src').each do |node|
  img_content = open(node).read
  file_name = File.join(local_dir, File.basename(node))
  puts "Fetching #{node}"
  if File.exist?(file_name)
    puts "file was exists. #{file_name}"
    next
  end
  File.open(file_name, 'w') do |file|
    file.write(img_content)
  end
  puts "Success... #{file_name}"
  sleep 1
end
