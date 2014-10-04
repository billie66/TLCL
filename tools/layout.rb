# encoding: utf-8

Dir['*.md'].each do |file|
  f = File.open("tmp/#{file}", 'w')
  str = File.read(file).gsub!(/layout: book/, 'layout: book-zh')
  f.write(str)
  f.close
end

`mv tmp/* .`
`rm -rf tmp`

