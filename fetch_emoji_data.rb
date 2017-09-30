require 'open-uri'

# Script pulls emoji definitions off of the Unicode website and
# creates an output.txt with just the codes for input to process.rb

unicode_url = 'https://www.unicode.org/Public/emoji/6.0/emoji-data.txt'
file_contents = open(unicode_url) { |f| f.read }
emoji_code_lines = file_contents.split("\n").map{ |x| x.split(" ;")[0] }.compact.map(&:rstrip)
output_file = 'emoji_sorted.txt'

emoji_codes = emoji_code_lines.each_with_object([]) do |line, result|
  case line
  when /^#/
    nil # don't include commented lines
  when /^(0023|002A|0030)/
    nil # don't include number sign, asterisk, or digits
  when /^.{4,5}\.\./
    start_code_hex, end_code_hex = line.split('..')
    base_10_code_range = (start_code_hex.to_i(16)..end_code_hex.to_i(16))
    hex_codes = base_10_code_range.to_a.map { |base_10_code| base_10_code.to_s(16).rjust(4, '0').upcase }
    hex_codes.each { |code| result << code }
  else
    result << line
  end
end

File.open(output_file, 'w') do |f|
  f << emoji_codes.uniq.join("\n")
end
