# build the blog from source.
require './build_helper'
require 'JSON'

require 'Find'
#require 'pry'
require 'kramdown'

#1 build index and about pages. 
def build_basic_pages
  puts __method__
  basic_pages = ['index.md', 'about.md']
  basic_pages.each do |path|  
    html_path = path.sub('.md','.html')              
    make_nice_html(path, html_path)
  end
end

def get_blog_mds_paths
  puts __method__
  paths = []
  Find.find('blog_src') do |path| paths << path if path =~ /.*\.md$/ end
  paths
end

def make_nice_html(source_md_path, tar_html_path)    
  text = File.read(source_md_path)
  File.write(tar_html_path, Kramdown::Document.new(text, input: 'GFM', coderay_line_numbers: nil).to_html)
  wrap_file_in_html(tar_html_path)      
end

#2 build blog_src/index.md
  #2.1 build list of posts, each with title, url, created_At
def get_internal_blog_posts_list
  puts __method__
  blog_posts = get_blog_mds_paths

  blog_posts.map! do |path| 
    hash = parse_firstline_comment_as_hash(path)
    next if (hash['draft'] || path=='blog_src/index.md')
    hash['title'] = hash['title'] || path.sub('blog_src/', '').sub('.md','')
    hash['url']   = hash['url']   || path.sub('blog_src/', '').sub('.md','.html')
    hash
  end

  blog_posts.compact! #remove nils
end

def get_blog_index_list
  puts __method__
  res = get_internal_blog_posts_list + get_external_links_list
  res.sort_by {|obj| obj['created_at'] || '-2000' }.reverse
end

def build_blog_index_md
  puts __method__
  content = "## Sella's Blog \n"
  content +="<!-- this file is auto-created. -->\n\n"
  content += "###### now that's what I'm talking about\n"
  get_blog_index_list.each do |item| 
    title = item['title']      || item[:title]
    url   = item['url']        || item[:url]
    created_at = item['created_at'] || item[:created_at]
    content+="* [#{title}](#{url})"
    content+="<span class='created_at'>#{created_at}</span>\n" if created_at
  end

  File.write('blog_src/index.md', content)   
end

def build_blog_html_files
  puts __method__
  paths = get_blog_mds_paths
  paths.each do |path| 
    html_path = path.sub('.md','.html').sub('_src','');
    make_nice_html(path, html_path)    
  end
end

build_basic_pages
build_blog_index_md
build_blog_html_files

