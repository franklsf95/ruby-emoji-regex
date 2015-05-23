require 'open-uri'

unicode_url = "http://www.unicode.org/Public/emoji/1.0/emoji-data.txt"
file_contents = open(unicode_url) { |f| f.read }
emoji_code = file_contents.split("\n").map{ |x| x.split(" ;\t")[0] }

File.open("output.txt", "w") do |f|
  emoji_code.each do |line|
    f << line << "\n" if line[0] != '#'
  end
end