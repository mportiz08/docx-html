require 'docx'
require 'docx/html/writer'

module Docx
  module Html
    class Converter
      DEFAULT_OPTIONS = {
        doctype: 5
      }

      def initialize(path, options={})
        @docx =  Docx::Document.open(path)
        @opts =  DEFAULT_OPTIONS.merge(options)
        @title = File.basename(path, '.docx') # TODO: add name to Docx::Document
      end

      def self.for(path)
        self.new(path).convert
      end

      def convert
        Html::Writer.new.write do |html|
          html.doctype @opts[:doctype]
          html.head do |head|
            head.title @title
          end
          html.body do |body|
            @docx.each_paragraph do |paragraph|
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
        inline_content
      end
      
      def wrap(text, tag)
        "<#{tag.to_s}>#{text}</#{tag.to_s}>"
      end
    end
  end
end
