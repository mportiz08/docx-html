require 'docx/html/converter'
require 'test/unit'

class TestConverter < Test::Unit::TestCase
  def test_basic_conversion
    expected = '<!DOCTYPE html><html><head><title>basic</title></head><body><p>hello</p><p>world</p></body></html>'
    actual   = Docx::Html::Converter.new('test/fixtures/basic.docx').convert
    assert_equal expected, actual
  end
  
  def test_conversion_with_formatting
    expected = '<!DOCTYPE html><html><head><title>formatting</title></head><body><p>Normal</p><p><em>Italic</em></p><p><strong>Bold</strong></p><p>Underline</p><p>Normal</p><p>This is a sentence with <strong><em>all</em></strong> formatting options in the middle of the sentence.</p></body></html>'
    actual   = Docx::Html::Converter.new('test/fixtures/formatting.docx').convert
    assert_equal expected, actual
  end
end
