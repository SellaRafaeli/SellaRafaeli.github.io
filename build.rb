#$ ruby generate_content.rb
require 'find'
require 'kramdown'
require 'erb'

def wrap_file_in_html(file_path, custom_content = nil)     
   basename = File.basename(file_path, ".html")
   basename = 'sellarafaeli.com' if basename == 'index'
   content  = "#{custom_content || File.read(file_path)}" 
   template = ERB.new File.read("/template.erb"), nil, "%"
   template = template.result(binding)
   template = "<html><head> <meta charset='utf-8'> <title>#{basename}</title>"+
                        '<meta name="viewport" content="width=device-width">'+
                        '<link rel="shortcut icon" href="/favicon_thumb.ico"/>'+
                        #'<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>'+
                        #'<link href="/css/github_markdown.css" rel="stylesheet"></link>'+
                        #'<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">'+
                        '<link href="/css/main.css" rel="stylesheet"></link>'+
                        #'<link href="/css/mobile.css" rel="stylesheet" media="handheld">'+
                        # '<link href="/css/swiss.css" rel="stylesheet"></link>'+
                        #'<link href="/css/markdown.css" rel="stylesheet"></link>'+
                        "</head>"+
                        '<body>'+
                        "<div class='top'><a href='/'>sellarafaeli.com</a></div>" + 
                        '<article class="markdown-body">'+                       
                        content+
                        '</article>'+
                        "<footer style='font-size:80%'>
    <div style='border-top:2px solid lightgrey; margin: 15px'></div>
    I <a href='/blog'>write extensively</a> about advanced web development and am available for <a href='/consulting.html'>consulting</a> anywhere in the world. 
    <div>© <a href='/'>sellarafaeli.com</a>, 2016</div>
  </footer>"+
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
  