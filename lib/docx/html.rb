require 'docx/html/converter'

module Docx
  module Html
    def self.for(path, options={})
      Converter.new(path, options).convert
    end
  end
end
