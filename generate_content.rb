#run ruby generate_content.rb blog_src
#1. Setup
tar_dir = ARGV[0]
puts "Converting Markdowns in folder #{tar_dir}"

md_file_paths = ['index.md']
html_paths = []

def wrap_file_in_html(file_path, custom_content = nil)     
   template = "<html><head> <meta charset='utf-8'> <title>#{File.basename(file_path, ".html")} </title>"+
                        '<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>'+
                        "</head>"+
                        '<body>'+
                        "<a href='/'>Home</a>" + "  |  " +
                        "<a href='/blog'>Blog</a>" +
                        "#{custom_content || File.read(file_path)}</body></html>"
   File.write(file_path,template)
end

def parse_firstline_comment_as_hash(path)
  first_line = File.open(path, &:readline)
  require 'JSON'
  JSON.parse (first_line.sub('<!--','').sub('-->','').strip)
rescue => e 
  puts "No comments for #{path}"; 
  return {}
end

#2. Find all Markdown files, remove all HTML files
require 'Find'
Find.find(tar_dir) do |path|
  md_file_paths << path if path =~ /.*\.md$/   
  (puts "removing #{path}...") && system("rm #{path}") if path =~ /.*\.html$/   
end

#2.5 generate blog/index.md
path = "#{tar_dir}/blog_src/index.md"
content = ""
content += "## Blog \n"
content+="<!-- this file is auto-created. -->\n\n"
#content += "## Sella's Blog\n "
content += "###### now that's what I'm talking about\n"
#md_file_paths.each do |path| content+="* #{File.basename(path, '.md')}\n" end
md_file_paths.each { |path| 
  link= File.basename(path, '.md');   
  metadata_hash = parse_firstline_comment_as_hash(path)
  puts "Adding #{link} to index.md"
  content+="* [#{link}](/blog/#{link}) - (#{metadata_hash['created_at']})\n" if link!='index' }

File.write(path, content) 

#3. Turn each of them into an HTML file with same name in same directory
md_file_paths.each do |path|
  html_path = path.sub('.md','.html').sub('_src','');  
  html_paths << html_path
  puts "generating #{path} into #{html_path}..."
  #system"cat #{path} | mdown > #{html_path}"                                                                ##<- use "mdown"
  require 'kramdown'
  text = File.read(path)
  File.write(html_path, Kramdown::Document.new(text, input: 'GFM', coderay_line_numbers: nil).to_html)      ## use Kramdown to parse Github-flavored-markdown (GFM)
  wrap_file_in_html(html_path)    
end

puts "Done!"
  