require 'docx/html/writer'
require 'test/unit'

class TestWriter < Test::Unit::TestCase
  def test_basic_html_writing
    expected = '<!DOCTYPE html><html><head><title>foo</title></head><body><p>hello, world</p></body></html>'
    assert_equal expected, basic_html
  end
  
  private
  
  def basic_html
    Docx::Html::Writer.new.write do |html|
      html.doctype 5
      html.head do |head|
        head.title 'foo'
      end
      html.body do |body|
        body.p 'hello, world'
      end
    end
  end
end
