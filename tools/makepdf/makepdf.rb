#encoding: utf-8
require 'kramdown'
require 'erb'

here = File.expand_path(File.dirname(__FILE__))
case ARGV[0]
when "en-cn"
  root = File.join("#{here}", '../../book')
  tex_file = "tlcl-en-cn.tex"
when "cn"
  root = File.join("#{here}", '../../book/zh')
  tex_file = "tlcl-cn.tex"
end

def replace(string, &block)
  string.instance_eval do
    alias :s :gsub!
    instance_eval(&block)
  end
  string
end

def post_tex(string)
  graphic_options = '[width=10cm,height=10cm,keepaspectratio]'

  replace(string) do
    # setup code blocks
    s /(\\begin\{verbatim\}.*?\\end\{verbatim\})/m, '{\footnotesize\1}'
    s /(\\begin\{verbatim\}.*?\\end\{verbatim\})/m, '\begin{shaded}\1\end{shaded}'
    s /(\\begin\{lstlisting\})\[(.*?)frame=tlbr\]/, '\1[\2frame=none]'
    s /(\\begin\{lstlisting\}.*?\\end\{lstlisting\})/m, '\begin{shaded}\1\end{shaded}'

    # setup graphic
    # s /\n(\\begin\{figure\})\n/, "\n\\1[H]\n"
    s /(\\includegraphics.*?)\s+\\textbackslash{}\n(.*?)\n/,
      "\\begin{figure}[H]\n\\begin{center}\n\\1\n\\caption{\\2}\n\\end{center}\\end{figure}"

    s /(\\includegraphics)/, "\n\\1#{graphic_options}"
    s /(\\caption\{\})/, ''

    # setup quotes
    s /(\\begin\{quote\}.*?\\end\{quote\})/m, '\begin{shaded}\1\end{shaded}'
    s /(\\begin\{quotation\}.*?\\end\{quotation\})/m, '\begin{shaded}\1\end{shaded}'

    # double quotes
    s /''(.*?)``/, "``\\1''"
    s /''(.*?)''/, "``\\1''"
    s /``(.*?)``/, "``\\1''"

    # horizonal lines
    s /\\rule{3in}/, '\\rule{\\textwidth}'

    # double dashes
    s /-\\{\\}-/, '-{}-'
  end
end

def convert_tables(string)
  pattern = /%\s<table class="multi">(.*?)%\s<\/table>/m
  tr = /<tr>(.*?)<\/tr>/m
  th = /<t[hd].*?>(.*?)<\/t[hd]>/m
  text = string.gsub(pattern) do |s|
    cap = s.scan(/%\s+\<caption class="cap"\>(.*?)\s*\<\/caption\>/)
    if not cap.empty?
      table_number = cap.first.first.match(/[0-9\s\-]+:/)[0].gsub!(/[\s:]/, '')
    end
    tmp = ''
    cols = 0
    tmp = s.scan(tr).map do |e|
        e = e.first.scan(th)
        cols = e.size
        e.map do |t|
          t.first.gsub(/\\/, '\\textbackslash{}').
            gsub(/#/, '\\\#').
            gsub(/&/, '\\\&').
            gsub(/_/, '\\\_').
            gsub(/~/, '\\~{}').
            gsub(/\$/, '\\$').
            gsub(/\\\${(.*?)}/, '\\textbackslash{}\$\{\1\}').
            gsub(/\^/, '\\textasciicircum').
            gsub(/\n%/, '').
            gsub(/%/, '\\%').
            gsub(/<b>(.*?)<\/b>/, '\\emph{\1}').
            gsub(/<br>/, '\\newline').
            gsub(/<p>(.*?)<\/p>/m, '\1 \\newline ').
            gsub(/<ul>(.*?)<\/ul>/m, "\\begin{itemize}\\1\\end{itemize}").
            gsub(/<li>(.*?)<\/li>/m, "\\item \\1").
            gsub(/--/, '-{}-')
        end.join('&') + "\\\\"  + ' \hline' + "\n"
      end.join
    len = case cols
          when 2
            if %w(4-3 6-2 12-4 13-1 15-1 17-1 23-3 23-4 28-2 28-3).include?(table_number)
              '{p{5cm}p{8cm}}'
            elsif table_number == "35-3"
              '{p{2cm}p{5cm}}'
            elsif %w(35-4 35-6).include?(table_number)
              '{p{4cm}p{9cm}}'
            else
              '{p{3cm}p{10cm}}'
            end
          when 3
            case table_number
            when "15-2"
              '{p{8cm}p{2cm}p{3cm}}'
            when "18-5"
              '{p{4cm}p{3cm}p{6cm}}'
            when "28-4"
              '{p{3cm}p{3cm}p{3cm}}'
            when "21-1"
              '{p{1cm}p{4cm}p{8cm}}'
            when "4-1", "11-3", "16-1"
              '{p{1cm}p{3cm}p{9cm}}'
            else
              '{p{2cm}p{2cm}p{9cm}}'
            end
          when 4
            '{p{2cm}p{2cm}p{2cm}p{2cm}}'
          end

    tab = "\n\\begin{longtable}[H]" + len + "\n\\hline\n"

    if cap.empty?
      content = tab + tmp + "\\end{longtable}\n"
    else
      content = tab + tmp + "\n\\caption{#{cap.first.first}}\n" + "\\end{longtable}\n"
    end
    content
  end
end

@tex = ""
@graphicspath = "#{root}/"
@date = Time.now.strftime("%F")

layout = /^---\nlayout:.*?\ntitle:(\p{Any}+?)\n---\n/

Dir.glob("#{root}/*.md").sort.each do |f|
  str = IO.read(f).lstrip
  title = layout.match(str).to_s.gsub!(layout, '\1').strip
  text = str.gsub(layout, '').
    gsub(/###/, '#').
    gsub(/####/, '##').
    gsub(/(<table class="multi">.*?<\/table>)/m, "\n{::comment}\n\\1\n{:/comment}\n").
    gsub(/-\\-/, "-{}-")

  doc = Kramdown::Document.new(
    text,
    :input => 'GFM',
    :hard_wrap => false
  ).to_latex

  @tex += "\\chapter{#{title}}\n\n" + convert_tables(doc)
end

tex = ERB.new(File.read("#{here}/template.tex.erb")).result()

post_tex(tex)

File.open("#{here}/#{tex_file}", "w+") do |f|
  f.write(tex)
end

3.times do
  system("xelatex #{here}/#{tex_file}")
end

# remove useless files
system("bash #{here}/clean")
