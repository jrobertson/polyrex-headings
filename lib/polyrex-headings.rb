#!/usr/bin/env ruby

# file: polyrex-headings.rb

require 'polyrex'

class PolyrexHeadings

  attr_reader :to_polyrex, :to_s

  def initialize(raw_s)

    # add an empty space to the blank line where there is no 
    # raw record between headings
    
    raw_s.gsub!(/(#+[^\n]+\n+)(?=\n#)/m,'\1 ')

    summary, *s = raw_s.split(/(?=(?:#|[^\n]+\n-+))/,2)

    a = if raw_s =~ /----/ then       

      s.join.lines.chunk{|x| x != "\n" }.map do |record, x| 

        if record then

          head = x.shift
          x.shift
          [head] + x.map{|y| '  ' + y}
        end
      end

    else

      s.join.split(/^\n*#/)[1..-1].map do |x|  

        lines = x.lines

        raw_heading = lines.shift.rstrip
        raw_indent = raw_heading.slice!(/#*/)
        n, heading = raw_indent.length, raw_heading.lstrip

        ([indent(n) + heading] + lines.map{|x| indent(n+1) + x}).join
      end

    end
    summary.sub!(/^(<\?)(ph|polyrex-headings)/,'\1polyrex')
    @to_s = string = summary + a.join

    @to_polyrex = Polyrex.new.parse(string)
  end

  private

  def indent(n)
    '  ' * (n)
  end

end
