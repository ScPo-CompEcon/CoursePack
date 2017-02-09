require 'fileutils'

Dir.chdir "Notebooks"
SOURCE_FILES = Rake::FileList.new("*.ipynb")
# puts SOURCE_FILES

task :default => :all 
task :all => [:html, :offline, :pdf, :md]
task :clean => [:clean_md,:clean_slides,:clean_html,:clean_pdf]
task :html => SOURCE_FILES.ext("html")
task :slides => SOURCE_FILES.ext("slides.html")
task :pdf => SOURCE_FILES.ext("pdf")
task :md => SOURCE_FILES.ext("md")
task :offline => :slides

task :clean_md do
	sh "rm -rf *.md"
	sh "rm -rf ../Markdown/*.md"
end
task :clean_html do
	sh "rm -rf *.html"
	sh "rm -rf ../Html/*.html"
end

task :clean_slides do
	sh "rm -rf *.slides.html"
	sh "rm -rf ../Slides/*.html"
end

task  :clean_pdf do
	sh "rm -rf *.pdf"
	sh "rm -rf ../Pdfs/*.pdf"
end


task :offline => :slides do 
	Dir.chdir "../OfflineSlides"
	# puts Dir.pwd
	puts "substituting all https libs to local copies"
	sh "find ./ -type f -exec sed -i '' s,https://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.10/require.min.js,require.js/require.js, {} +;"
	sh "find ./ -type f -exec sed -i '' s,https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js,jquery.js/jquery.js, {} +;"
	# sh "find ./ -type f -exec sed -i '' s#https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML#MathJax.js/Mathjax.js?config=TeX-AMS_HTML# {} +;"
	sh "find ./ -type f -exec sed -i '' s,//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.css,font-awesome-4.7.0/css/font-awesome.css, {} +;"
	# change reveal.js theme to x
	sh "find ./ -type f -exec sed -i '' s,reveal.js/css/theme/simple.css,reveal.js/css/theme/solarized.css, {} +;"
	Dir.chdir "../Notebooks"
end


rule ".html" => ".ipynb" do |t|
	sh "which python"
	sh "jupyter-nbconvert --to html #{t.source}"
	FileUtils.mv("#{t.name}", "../Html/#{t.name}")
end

# special rule for .slides.html file ending!
rule( /\.slides\.html$/ => [
    proc {|task_name| task_name.sub(/\.slides\.html$/, '.ipynb') }
]) do |t|
	sh "jupyter-nbconvert --to slides #{t.source} --reveal-prefix=reveal.js"
	FileUtils.cp("#{t.name}", File.join("..","Slides",File.basename("#{t.name}",".slides.html")+".html"))
	FileUtils.cp("#{t.name}", File.join("..","OfflineSlides",File.basename("#{t.name}",".slides.html")+".html"))
	Dir.chdir "../Slides"
	sh "find ./ -type f -exec sed -i '' s,reveal.js/css/theme/simple.css,reveal.js/css/theme/solarized.css, {} +;"
	Dir.chdir "../Notebooks"
	sh "rm -rf #{t.name}"
end

rule ".pdf" => ".ipynb" do |t|
	sh "jupyter-nbconvert --to pdf #{t.source}"
	FileUtils.mv("#{t.name}", "../Pdfs/#{t.name}")
end

rule ".md" => ".ipynb" do |t|
	sh "jupyter-nbconvert --to markdown #{t.source}"
	FileUtils.mv("#{t.name}", "../Markdown/#{t.name}")
end


# task :publish => :build do
# 	puts "publishing repo to github"
# end

# task :slides do
# 	puts "Making Slides from Notebooks"
# 	Rake::FileList['*.ipynb'].each

# end

# task :build => [:slides, :pdf, :markdown, :html] do
# 	puts "Build entire CoursePack: Slides, pdf, Markdown and Html"
# end

