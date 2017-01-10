#!/usr/bin/env ruby

# file: polyrex-headings.rb

require 'polyrex'

class PolyrexHeadings

  attr_reader :to_polyrex, :to_s

  def initialize(raw_s)

    # add an empty space to the blank line where there is no 
    # raw record between headings
    
    raw_s.gsub!(/(#+[^\n]+\n+)(?=\n#)/m,'\1 ')
    summary, *s = raw_s.split(/(?=(?:^#|[\n]+\n-+))/,2)
    type = nil

    a = if raw_s =~ /----/ then       
    
      # this was the original code which used dashes to make an underline 
      # of a heading. Typically the heading is now prefixed with a hash (#)
      # which means this block is unlikely to be executed.

      s.join.lines.chunk{|x| x != "\n" }.map do |record, x| 

        if record then

          head = x.shift
          x.shift
          [head] + x.map{|y| '  ' + y}
        end
      end

    else
      
      a2 = summary.gsub(/\n{2,}/,"\n").lines

      if a2.last =~ /^--+/ then
        a2.pop
        summary = a2.join
        type = :rowx 
      end
        
      s.join.split(/^\n*#/)[1..-1].map do |x|  
        
        lines = x.lines
        raw_heading = lines.shift.rstrip        
        
        body = lines.join.strip

        if type == :rowx and body.length > 0

          lines2 = ["\n"] + 
              RowX.new(body, level: 0).to_lines(delimiter: ' # ') << "\n"
        else

          lines2 = lines
        end

        raw_indent = raw_heading.slice!(/#*/)
        n, heading = raw_indent.length, raw_heading.lstrip

        ([indent(n) + heading] + lines2.map{|x| indent(n+1) + x}).join        
      end

    end
    summary.sub!(/^(<\?)(ph|polyrex-headings)/,'\1polyrex')
    @to_s = string = summary + a.join
    
    px = Polyrex.new
    px.parse(string, delimiter: ' # ')
    
    @to_polyrex = px

  end

  private

  def indent(n)
    '  ' * (n)
  end

end
