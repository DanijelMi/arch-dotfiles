#!/bin/bash 
# Author: Danijel Milosevic
# License: Beerware
# Dependencies: tesseract-data-eng imagemagick scrot xclip
SRC_IMG=/tmp/tesseract_ocr_image.png        # Location of temporary image
SRC_RST=/tmp/tesseract_ocr_result.txt       # Location of text result

scrot -s $SRC_IMG -q 100    # Select image and temporarily store
# increase image quality with option -q from default 75 to 100
mogrify -set units PixelsPerInch -density 300 -modulate 100,0 -resize 200% $SRC_IMG
# Modify image to improve detection rate
tesseract -l eng --dpi 300 $SRC_IMG /tmp/tesseract_ocr_result
cat /tmp/tesseract_ocr_result.txt | xclip -sel clipboard
rm $SRC_IMG $SRC_RST