#1. Setup
tar_dir = ARGV[0]
puts "Converting Markdowns to HTML in folder #{tar_dir}"

md_file_paths = []
html_paths = []

def wrap_file_in_html(file_path)     
   template = "<html><head><title>#{File.basename(file_path)} </title>"+
                        '<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>'+
                        "</head><body>#{File.read(file_path)}</body></html>"
   File.write(file_path,template)
end


#2. Find all Markdown files, remove all HTML files
require ('Find')
Find.find(tar_dir) do |path|
  md_file_paths << path if path =~ /.*\.md$/   
  (puts "removing #{path}...") && system("rm #{path}") if path =~ /.*\.html$/   
end

#3. Turn each of them into an HTML file with same name in same directory
md_file_paths.each do |path|
  html_path = path.sub('.md','.html');  
  html_paths << html_path
  puts "generating #{path} into #{html_path}..."
  system"cat #{path} | mdown > #{html_path}"
  wrap_file_in_html(html_path)    
end


puts "Done!"
  