#!/bin/bash
# Problem 5
# Organize files within a zipped tar file. 
# Unzip file, create subfolders for each file extension, place files within 
# folders by extension, zip folder structure

#initial stuff
zipname=$1
filename=MISC
# create clean folder, move zip, unzip
mkdir MISC_clean
cp $zipname MISC_clean
cd MISC_clean
tar xvzf $zipname

# create ext directories
mkdir scssdir
mkdir jsdir
mkdir mddir
mkdir ymldir
mkdir htmldir
mkdir eotdir
mkdir svgdir
mkdir ttfdir
mkdir lockdir
mkdir pdfdir
mkdir jsondir
mkdir pngdir

# for loops to move files to sorted directories
for file in *.scss ; do
        mv $file scssdir
done

for file in *.js ; do
        mv $file jsdir
done

for file in *.md ; do
        mv $file mddir
done

for file in *.yml ; do
        mv $file ymldir
done

for file in *.html ; do
        mv $file htmldir
done

for file in *.eot ; do
        mv $file eotdir
done

for file in *.svg ; do
        mv $file svgdir
done

for file in *.ttf ; do
        mv $file ttfdir
done

for file in *.lock ; do
        mv $file lockdir
done

for file in *.pdf ; do
        mv $file pdfdir
done

for file in *.json ; do
        mv $file jsondir
done

for file in *.png ; do
        mv $file pngdir
done

# remove the original zip file to exclude it from new zip
rm $zipname

#rezip resulting folder
cd ../
tar -czvf MISC_clean.tar.gz MISC_clean
rm -rf MISC_clean
