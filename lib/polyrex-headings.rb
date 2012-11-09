#!/usr/bin/env ruby

# file: polyrex-headings.rb

require 'polyrex'

class PolyrexHeadings

  attr_reader :to_polyrex

  def initialize(raw_s)

    summary, *s = raw_s.gsub(/(-+\n)\n/,'\1').partition(/[^\n]+\n-+/)
      
    a = s.join.lines.chunk{|x| x != "\n" }.map do |record, x| 
      if record then
        head = x.shift
        x.shift
        [head] + x.map{|y| '  ' + y}
      end
    end

    summary.sub!(/^(<\?)(ph|polyrex-headings)/,'\1polyrex')
    @to_polyrex = Polyrex.new.parse(summary + a.join)
  end

end
