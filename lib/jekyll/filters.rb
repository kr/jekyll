module Jekyll
  
  module Filters
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
      input.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;")
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

    def educate(input)
      Smartypants.educate_string(input)
    end

    def markdown(input)
      Maruku.new(input).to_html
    end
  end  

  # Maruku, inexplicably, offers no way to access its Smartypants
  # implementation outside of the Markdown interface. So here's a hack.
  class Smartypants; end
  class << Smartypants
    include MaRuKu::In::Markdown::SpanLevelParser
    include MaRuKu::Helpers
    def educate_string(s)
      educate([s]).map{ |x| x.to_html_entity rescue x }.join
    end
  end
end
