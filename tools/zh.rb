#!/usr/bin/env ruby
# coding: utf-8

root = File.expand_path(File.dirname(__FILE__), '../book')
tmpdir = File.join(root, 'tmp')
outdir = File.join(root, 'zh')

Dir.mkdir(tmpdir) if !Dir.exist?(tmpdir)
Dir.mkdir(outdir) if !Dir.exist?(outdir)

Dir.glob("#{root}/*.md") do |file|
  flag  = false
  token = false
  count = 0

  tmpfname = File.join(tmpdir, file.split('/').last)
  outfname = File.join(outdir, file.split('/').last)

  out = File.open(tmpfname, 'w')

  File.open(file, 'r').each_line do |line|
    case line
    when /^---$/, /^layout: book$/, /^title:/, /^<div/, /<\/div>/
      out << line
    when /<http:/, /^$/, /^\s{4}/, /<br \/>/
      out << line
    when /<img/, /class=\"figure\"/
      out << line
    when /<center>/
      token = true
      out << line
    when /<\/center>/
      token = false
      out << line
    when /^<table/
      count += 1 if !token
      flag = true
      out << line if count % 2 == 0
    when /table>$/
      flag = false
      out << line if count % 2 == 0
    else
      if !line.force_encoding("UTF-8").gsub(/[[:punct:]]/, '').ascii_only?
        out << line
      elsif count % 2 == 0 && flag == true
        out << line
      elsif token == true
        out << line
      end
    end
  end

  out.close

  system("uniq < #{tmpfname} > #{outfname}")
end

system("rm -rf #{tmpdir}")

puts "Done!"
