#run ruby generate_content.rb blog_src

if !ARGV[0] 
  puts 'usage: ruby generate_content.rb blog_src'
  exit(0)
end

#1. Setup
tar_dir = ARGV[0]
puts "Converting Markdowns in folder #{tar_dir}"

md_file_paths = ['index.md', 'about.md']
html_paths = []

def wrap_file_in_html(file_path, custom_content = nil)     
   template = "<html><head> <meta charset='utf-8'> <title>#{File.basename(file_path, ".html")} </title>"+
                        #'<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>'+
                        '<link href="https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css" rel="stylesheet"></link>'+
                        '<link href="/assets/main.css" rel="stylesheet"></link>'+
                        "</head>"+
                        '<body>'+
                        '<article class="markdown-body">'+
                        "<a href='/'>Home</a>" + "  |  " +
                        "<a href='/blog'>Blog</a>" +                        
                        "#{custom_content || File.read(file_path)}"+
                        '</article>'+
                        "</body></html>"
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
  (puts "removing #{path}...") && system("rm #{path}") if path =~ /.*\.html$/    #careful not to remove HTMLs from other folders! :) 
end

#2.5 generate blog/index.md
puts "generating blog/index.md"
path = "#{tar_dir}/index.md"
content = ""
content += "## Sella's Blog \n"
content+="<!-- this file is auto-created. -->\n\n"
#content += "## Sella's Blog\n "
content += "###### now that's what I'm talking about\n"
#md_file_paths.each do |path| content+="* #{File.basename(path, '.md')}\n" end
md_file_paths.each { |path| 
  link= File.basename(path, '.md');   
  metadata_hash = parse_firstline_comment_as_hash(path)
  puts "Adding #{link} to index.md"
  content+="* [#{link}](/blog/#{link}) - (#{metadata_hash['created_at']})\n" if (link!='index' && link!='about') unless metadata_hash['draft']}

external_links = [];
external_links.push({title: "Git 'Rebase' For Startups", url: 'https://medium.com/@sellarafaeli/we-use-git-rebase-and-so-should-you-be89d1932a14', created_at: '2014-01-30'})
external_links.push({title: "Git  Rebase -i Belong To Us", url: 'https://medium.com/@sellarafaeli/git-rebase-i-belong-to-us-4d7010387683', created_at: '2014-02-17'})
external_links.push({title: "Daat - A Good Hebrew Content Site", url: 'https://medium.com/@sellarafaeli/reading-4bb50bc5168b', created_at: '2014-09-02'})

external_links.each { |link| content+="* [#{link[:title]}](#{link[:url]}) - (#{link[:created_at]})\n" }
content+= "* Older posts (2009-2014): [http://sellarafaeli.wordpress.com](http://sellarafaeli.wordpress.com)"

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
  