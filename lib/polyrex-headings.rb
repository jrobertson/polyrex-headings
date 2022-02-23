#!/usr/bin/env ruby

# file: polyrex-headings.rb

require 'polyrex'
require 'rxfreader'


class PolyrexHeadingsException < Exception
end

class PolyrexHeadings

  attr_reader :to_polyrex, :to_px, :to_s

  def initialize(raw_s, debug: false)

    @debug = debug
    buffer, type = RXFReader.read(raw_s)

    if type == :unknown and buffer.lines.length <= 1 then
      raise PolyrexHeadingsException, 'File not found'
    end

    # add an empty space to the blank line where there is no
    # raw record between headings

    buffer.gsub!(/(#+[^\n]+\n+)(?=\n#)/m,'\1 ')
    summary, *s = buffer.split(/(?=(?:^#|[\n]+\n-+))/,2)
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

    @to_polyrex = @to_px = @px = px

  end

  def to_h(symbolise: true)
    build(@px.records, symbolise)
  end

  private

  def build(records, symbolise)

    a = records.map do |record|

      if @debug then
        puts 'record.records: ' + record.records.inspect
        puts 'record.x: ' + record.x.inspect
      end

      if record.records.any? then

        key = symbolise ? record.x.downcase.to_sym : record.x
        {key => build(record.records, symbolise)}

      elsif record.x =~ /^[^:]+:\s/ then
        raw_key, value = record.x.split(/:\s+/,2)
        key = symbolise ? raw_key.downcase.to_sym : raw_key
        {key => value}

      else

        record.x

      end

    end

    puts 'a.first: ' + a.first.inspect if @debug
    return a.inject({}) {|r,x| r.merge!(x)} if a.first.is_a? Hash

    a

  end

  def indent(n)
    '  ' * (n)
  end

end
