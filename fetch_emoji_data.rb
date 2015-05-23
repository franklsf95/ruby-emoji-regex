require 'open-uri'

# Script pulls emoji definitions off of the Unicode website and
# creates an output.txt with just the codes for input to process.rb

unicode_url = 'http://www.unicode.org/Public/emoji/1.0/emoji-data.txt'
file_contents = open(unicode_url) { |f| f.read }
emoji_code = file_contents.split("\n").map{ |x| x.split(" ;\t")[0] }
output_file = 'emoji_sorted.txt'

File.open(output_file, 'w') do |f|
  emoji_code.each do |line|
    f << line << "\n" if line[0] != '#'
  end
end
