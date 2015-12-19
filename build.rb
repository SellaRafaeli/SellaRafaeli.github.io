#$ ruby generate_content.rb
require 'find'
require 'kramdown'

def wrap_file_in_html(file_path, custom_content = nil)     
   template = "<html><head> <meta charset='utf-8'> <title>#{File.basename(file_path, ".html")} </title>"+
                        #'<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>'+
                        '<link href="https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css" rel="stylesheet"></link>'+
                        '<link href="/main.css" rel="stylesheet"></link>'+
                        "</head>"+
                        '<body>'+
                        '<article class="markdown-body">'+
                        "<a href='/'>Home</a>" + "  |  " +
                        "#{custom_content || File.read(file_path)}"+
                        '</article>'+
                        "</body></html>"
   File.write(file_path,template)
end

#2. Find all Markdown files
md_file_paths = Find.find('.').to_a.select {|f| f =~ /.*\.md$/ }

#3. Turn each of them into an HTML file with same name in same place. 
md_file_paths.each do |path|
  html_path = path.sub('.md','.html')
  puts "generating #{path} into #{html_path}..."
  text = File.read(path)
  File.write(html_path, Kramdown::Document.new(text, input: 'GFM', coderay_line_numbers: nil).to_html)      ## use Kramdown to parse Github-flavored-markdown (GFM)
  wrap_file_in_html(html_path)    
end

puts "Done!"
  