#!/bin/bash

# Generate the Slides and Pages
jupyter-nbconvert Notebooks/Index.ipynb --reveal-prefix=reveal.js
mv Notebooks/Index.html  index.html


# jupyter-nbconvert --to slides Notebooks/basic-computing.ipynb --post serve 
jupyter-nbconvert --to slides Notebooks/BasicComputing.ipynb --reveal-prefix=reveal.js
# Move to the Slides directory
mv Notebooks/BasicComputing.slides.html  Slides/BasicComputing.html

# cd Notebooks
# arr=(*.ipynb)
# cd ..
# for f in "${arr[@]}"; do
#    # Chop off the extension
#    filename=$(basename "$f")
#    extension="${filename##*.}"
#    filename="${filename%.*}"

#    # Convert the Notebook to HTML
#    jupyter-nbconvert --to html Notebooks/"$filename".ipynb
#    # Move to the Html directory
#    mv Notebooks/"$filename".html  Html/"$filename".html

#    # Convert the Notebook to slides
#    jupyter-nbconvert --to slides Notebooks/"$filename".ipynb --reveal-prefix=./Slides/reveal.js
#    # Move to the Slides directory
   # mv Notebooks/"$filename".slides.html  Slides/"$filename".html

   # Convert the Notebook to Markdown
   # jupyter-nbconvert --to markdown Notebooks/"$filename".ipynb
   # # Move to the Markdown directory
   # mv Notebooks/"$filename".md  Markdown/"$filename".md

   # # Convert the Notebook to Latex
   # jupyter-nbconvert --to latex Notebooks/"$filename".ipynb
   # # Move to the Tex directory
   # mv Notebooks/"$filename".tex  Tex/"$filename".tex

   # # Convert the Notebook to Pdf
   # cp Notebooks/"$filename".ipynb src/"$filename".ipynb
   # cd src
   # jupyter-nbconvert --to pdf "$filename".ipynb
   # # Move to the html directory
   # mv "$filename".pdf  ../Pdfs/"$filename".pdf
#    rm "$filename".ipynb
#    cd ..
# done
