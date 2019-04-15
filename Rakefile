require 'fileutils'

# Dir.chdir "Notebooks"
SOURCE_FILES = Rake::FileList.new("Notebooks/*.ipynb")
# puts SOURCE_FILES
ROOT = File.dirname(__FILE__)

task :default => :all 

desc "build html, pdf, slides and pure markdown slides"
task :all => [:html, :pdf, :slides, :mkdown]
task :nopdf => [:html, :slides, :mkdown]
task :clean => [:clean_md,:clean_slides,:clean_pdf]

desc "convert notebook to html"
task :html => SOURCE_FILES.ext("html")

desc "convert notebook to html slides"
task :slides => SOURCE_FILES.ext("slides.html")

desc "convert notebook to pdf"
task :pdf => SOURCE_FILES.ext("pdf")

desc "clean slides"
task :clean_slides do
	sh "rm -rf Notebooks/*.slides.html"
	sh "rm -rf Slides/*.html"
end

desc "build pure markdown slides"
task :mkdown do
	puts "build markdown slides with backslide and move to static"
	Dir.chdir "Markdown/intro"
	sh "bs export"
	FileUtils.cp("dist/presentation.html","#{ROOT}/assets/static/HTML/intro.html")
	sh "bs pdf"
	FileUtils.cp("pdf/presentation.pdf","#{ROOT}/assets/static/pdf/intro.pdf")
	Dir.chdir "#{ROOT}"
end

rule ".html" => ".ipynb" do |t|
	puts "#{t.source}"
	sh "jupyter-nbconvert --to html #{t.source}"
	if "#{t.name}" == "Notebooks/Index.html"
		FileUtils.mv("#{t.name}", "index.html")
	else
		FileUtils.mv("#{t.name}", "Html/#{File.basename(t.name)}")
	end

end

# special rule for .slides.html file ending!
rule( /\.slides\.html$/ => [
    proc {|task_name| task_name.sub(/\.slides\.html$/, '.ipynb') }
]) do |t|
	sh "jupyter-nbconvert --to slides #{t.source} --reveal-prefix=reveal.js --SlidesExporter.reveal_theme=serif --SlidesExporter.reveal_scroll=True --SlidesExporter.reveal_transition=none"
	# sh "jupyter-nbconvert --to slides #{t.source} "
	FileUtils.cp("#{t.name}", File.join("Slides",File.basename("#{t.name}",".slides.html")+".html"))
	sh "rm -rf #{t.name}"
end



rule ".pdf" => ".ipynb" do |t|
	# exclude those from bibtex citations
	exclude = ["BasicComputing","BasicIntroduction","Index","PlotsJL","HPC","data_statistical_packages","fundamental_types","fundamental_types-solutions","getting_started","GrowthModelSolutionMethods_jl","introduction_to_types","julia_by_example-solutions","julia_by_example","julia_essentials","need_for_speed","testing","tools_editors","CEPM","HW1-solutions","HW1","Answers1","exercises1","languages-benchmark"]
	no_bib = ["mpec-starters","CEPM","optimization","optimization2"]
	bn = File.basename("#{t.source}")
	b  = File.basename("#{t.source}",".ipynb")
	dir = File.dirname("#{t.name}")
	# puts "#{dir}"
	# sh "jupyter-nbconvert --to pdf #{t.source}"
	if !(exclude.include?b)
		sh "jupyter nbconvert #{t.source} --to latex --template assets/templates/citations.tplx --output-dir=Pdfs"
		Dir.chdir "Pdfs"
		sh "xelatex #{bn.ext('tex')}"
		if !(no_bib.include?b)
			sh "bibtex #{bn.ext('aux')}"
			sh "xelatex #{bn.ext('tex')}"
			sh "xelatex #{bn.ext('tex')}"
			sh "xelatex #{bn.ext('tex')}"
		end
		sh "rm -rf *.tex *.aux *.synctex.gz *.nav *.dvi *.bbl *.blg *.out *.log"
		Dir.chdir ".."
	end
end

rule ".md" => ".ipynb" do |t|
	sh "jupyter-nbconvert --to markdown #{t.source}"
	FileUtils.mv("#{t.name}", "../Markdown/#{t.name}")
end
