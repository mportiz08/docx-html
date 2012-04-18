require 'docx'
require 'html_writer'

require 'docx/html/version'

module Docx
  class Document
    def to_html(options={})
      HtmlWriter.new.write do |html|
        html.doctype options[:doctype] || 5
        html.head do |head|
          head.title options[:title] || ''
        end
        html.body do |body|
          self.each_paragraph do |paragraph|
            body.p paragraph.text_runs.map{ |tr| inline_content_for(tr) }.join('')
          end
        end
      end
    end
    
    private
    
    def inline_content_for(text_run)
      inline_content = text_run.text
      inline_content = wrap(inline_content, :em)     if text_run.italicized?
      inline_content = wrap(inline_content, :strong) if text_run.bolded?
      inline_content = wrap(inline_content, :span,
        {style: 'text-decoration: underline;'})      if text_run.underlined?
      inline_content
    end
    
    def wrap(text, tag, attrs=nil)
      html = "<#{tag.to_s}"
      unless attrs.nil?
        attrs.each { |k,v| html << " #{k.to_s}=\"#{v.to_s}\""}
      end
      html << ">#{text}</#{tag.to_s}>"
    end
  end
end
