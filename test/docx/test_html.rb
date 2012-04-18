require 'docx/html'
require 'test/unit'

class TestHtml < Test::Unit::TestCase
  def test_basic_conversion
    expected =
      '<!DOCTYPE html>'\
      '<html>'\
      '<head>'\
        '<title>basic</title>'\
      '</head>'\
      '<body>'\
        '<p>hello</p>'\
        '<p>world</p>'\
      '</body>'\
      '</html>'
    actual = Docx::Document.open('test/fixtures/basic.docx').to_html(title: 'basic')
    assert_equal expected, actual
  end
  
  def test_conversion_with_formatting
    expected =
      '<!DOCTYPE html>'\
      '<html>'\
      '<head>'\
        '<title>formatting</title>'\
      '</head>'\
      '<body>'\
        '<p>Normal</p>'\
        '<p><em>Italic</em></p>'\
        '<p><strong>Bold</strong></p>'\
        '<p><span style="text-decoration: underline;">Underline</span></p>'\
        '<p>Normal</p>'\
        '<p>'\
          'This is a sentence with '\
          '<span style="text-decoration: underline;"><strong><em>all</em></strong></span> '\
          'formatting options in the middle of the sentence.'\
        '</p>'\
        '</body>'\
        '</html>'
    actual = Docx::Document.open('test/fixtures/formatting.docx').to_html(title: 'formatting')
    assert_equal expected, actual
  end
end
