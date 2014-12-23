def wrap_file_in_html(file_path, custom_content = nil)     
    puts "wrapping "+file_path    
    template = "<html><head> <meta charset='utf-8'> <title>#{File.basename(file_path, ".html")} </title>"+
                        #'<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>'+
                        '<link href="https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css" rel="stylesheet"></link>'+
                        '<link href="/assets/main.css" rel="stylesheet"></link>'+                        
                        "</head>"+
                        '<body>'+
                        '<article class="markdown-body">'+
                        "<a href='/'>SellaRafaeli.com Home</a>" + "  |  " +
                        "<a href='/blog'>Blog</a>" +                        
                        "#{custom_content || File.read(file_path)}"+
                        '</article>'+
                        "</body></html>"
   File.write(file_path,template)
end

def get_external_links_list
  puts __method__
  external_links = [];
  external_links.push({title: "Git 'Rebase' For Startups", 
                    url: 'https://medium.com/@sellarafaeli/we-use-git-rebase-and-so-should-you-be89d1932a14', 
                    'created_at' => '2014-01-30'})
  external_links.push({title: "Git Rebase -i Belong To Us", 
                     url: 'https://medium.com/@sellarafaeli/git-rebase-i-belong-to-us-4d7010387683', 
                     'created_at' => '2014-02-17'})
  external_links.push({title: "Daat - A Good Hebrew Content Site", 
                      url: 'https://medium.com/@sellarafaeli/reading-4bb50bc5168b',
                      'created_at' => '2014-09-02'})
  external_links.push({title: "Older posts - 2009-2014", 
                      url: 'http://sellarafaeli.wordpress.com'})
  return external_links
end

def parse_firstline_comment_as_hash(path)
  first_line = File.open(path, &:readline)
  require 'JSON'
  JSON.parse (first_line.sub('<!--','').sub('-->','').strip)
rescue => e 
  #puts "No comments for #{path}"; 
  return {}
end