# docx-html

an extension to the `docx` gem that provides a `to_html` method for documents

## install

    gem install docx-html

## usage

``` ruby
require 'docx/html'

d = Docx::Document.open('test.docx')
d.to_html
```
