#!/usr/bin/env ruby

input_file = 'emoji_sorted.txt'

prev = -1
prev_hex = ''
left = ''
right = -1
in_range = false
ranges = []

File.open(input_file).each do |line|
    hex = line.to_i(16)
    if hex == prev || hex == prev + 1
        # Continuous
        prev = hex
        prev_hex = line.chomp
        next
    else
        # Save previous range
        # puts "Break: #{line.chomp}  #{prev_hex}"
        length = prev - left.to_i(16) + 1
        ranges << [left, prev_hex]
        puts "Range: #{left} - #{prev_hex} | #{length}"
        # New range
        left = line.chomp
        prev = hex
        prev_hex = left
    end
end
regex = '['
ranges.each do |e|
    l = e[0]
    r = e[1]
    next if l == '' || r == '' || !l[/\s/].nil? || !r[/\s/].nil?
    if l == r
        regex += "\\u{#{l}}"
    else
        regex += "\\u{#{l}}-\\u{#{r}}"
    end
end
regex += ']'
puts regex
