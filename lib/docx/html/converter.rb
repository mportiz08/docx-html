require 'docx'
require 'docx/html/writer'

module Docx
  module Html
    class Converter
      DEFAULT_OPTIONS = {
        doctype: 5
      }

      def initialize(path, options={})
        @docx = Docx::Document.open(path)
        @opts = DEFAULT_OPTIONS.merge(options)
      end

      def self.for(path)
        self.new(path).convert
      end

      def convert
        return @docx.to_s
        Html::Writer.new do |html|
          html.doctype @opts.doctype
          html.body do |body|
            @doc.each_paragraph do |paragraph|
              body.p do |p|
                paragraph.each_text_run do |tr|
                  p inline_content_for tr
                end
              end
            end
          end
        end
      end

      def inline_content_for(text)
        text # TODO
      end
    end
  end
end
