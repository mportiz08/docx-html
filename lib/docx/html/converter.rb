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
              paragraph.each_text_run do |tr|
                body.p inline_content_for(tr)
              end
            end
          end
        end
      end
      
      private

      def inline_content_for(text_run)
        text_run.text # TODO
      end
    end
  end
end
