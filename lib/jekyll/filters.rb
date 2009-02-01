module Jekyll

  module Filters
    def textilize(input)
      RedCloth.new(input).to_html
    end

    def date_to_string(date)
      date.strftime("%d %b %Y")
    end

    def date_to_long_string(date)
      date.strftime("%d %B %Y")
    end

    def date_to_xmlschema(date)
      date.xmlschema
    end

    def xml_escape(input)
      CGI.escapeHTML(input)
    end

    def cgi_escape(input)
      CGI::escape(input)
    end

    def number_of_words(input)
      input.split.length
    end

    def array_to_sentence_string(array)
      connector = "and"
      case array.length
      when 0
        ""
      when 1
        array[0].to_s
      when 2
        "#{array[0]} #{connector} #{array[1]}"
      else
        "#{array[0...-1].join(', ')}, #{connector} #{array[-1]}"
      end
    end

    def smartypants_educate(input)
      Smartypants.educate_string(input)
    end
  end

  # Maruku seems to offer no way to access its Smartypants
  # implementation outside of the Markdown interface. So here is a hack.
  class Smartypants; end
  class << Smartypants
    require 'maruku'
    include MaRuKu::In::Markdown::SpanLevelParser
    include MaRuKu::Helpers
    def educate_string(s)
      educate([s]).map{ |x| x.to_html_entity rescue x }.join
    end
  end
end
