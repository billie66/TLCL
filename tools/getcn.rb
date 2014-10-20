# encoding: utf-8

en_cn = ARGV[0]
if ARGV[0] == "all"
  en_cn = '*'
else
  en_cn = ARGV[0]
end
root = File.expand_path(File.dirname(__FILE__), '../book')
tmpdir = File.join(root, 'tmp')
outdir = File.join(root, 'zh')

Dir.mkdir(tmpdir) if !Dir.exist?(tmpdir)
Dir.mkdir(outdir) if !Dir.exist?(outdir)

Dir.glob("#{root}/#{en_cn}.md") do |file|
  flag  = false
  count = 0

  tmpfname = File.join(tmpdir, file.split('/').last)
  outfname = File.join(outdir, file.split('/').last)

  File.open(tmpfname, 'w') do |out|

    File.open(file, 'r').each_line do |line|
      case line
      when /^---$/, /^title:/, /\{: \.figure\}/
        out << line
      when /^layout: book$/
        out << line.gsub('book', 'book-zh')
      when /^\#{3,4}/ # header
        out << line
      when /^!\[\]/ # figure
        out << line.gsub('images', '../images')
      when /^\s{4}/, /^>$/, /^>\s{2,5}/ # code blocks and blockquotes
        out << line
      when /^$/ # blank lines
        out << line
      when /^\s{2,4}\-?\s?<http:.*?>$/, /^\*.*?<http:.*?>$/
        out << line
      when /^\|.*?\|$/ # kramdown tables
        out << line
      when /^_\$.*?_$/, /^\*\s_.*?_$/
        out << line
      when /^<table/
        count += 1
        flag = true
        out << line if count.even?
      when /table>$/
        flag = false
        out << line if count.even?
      else
        if !line.force_encoding("UTF-8").gsub(/[[:punct:]]/, '').ascii_only?
          out << line
        elsif count.even? && flag == true
          out << line
        end
      end
    end

  end
  system("uniq < #{tmpfname} > #{outfname}")
end

system("rm -rf #{tmpdir}")

puts "Done!"
