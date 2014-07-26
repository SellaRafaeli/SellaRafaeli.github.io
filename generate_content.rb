tar_dir = ARGV[0]
puts "Converting Markdowns to HTML in folder #{tar_dir}"

md_file_paths = []


#Find all Markdown files, remove all HTML files
require ('Find')
Find.find(tar_dir) do |path|
  md_file_paths << path if path =~ /.*\.md$/   
  (puts "removing #{path}...") && system("rm #{path}") if path =~ /.*\.html$/   
end

#Turn each of them into an HTML file with same name in same directory
md_file_paths.each do |path|
  html_path = path.sub('.md','.html');  
  puts "generating #{path} into #{html_path}..."
  system"cat #{path} | mdown > #{html_path}"
end

puts "Done!"
  