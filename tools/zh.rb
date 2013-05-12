#!/usr/bin/env ruby 
# coding: utf-8

root = File.expand_path(File.dirname(__FILE__), '../book')
outdir = File.join(root, 'zh')

Dir.mkdir(outdir) if !Dir.exist?(outdir)

Dir.glob("#{root}/*.md") do |file|
  flag  = false 
  token = false 
  count = 0

  outfname = File.join(outdir, file.split('/').last)
  out = File.open(outfname, 'w')

  File.open(file, 'r').each_line do |line|
    case line 
    when /^---$/, /^layout: book$/, /^title:/, /^<div/, /<\/div>/
      out << line
    when /<http:/, /^$/, /^\s{2}/, /<br \/>/
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
      count += 1 
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
end
