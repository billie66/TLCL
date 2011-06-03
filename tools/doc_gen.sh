#!/bin/bash

#################################
#
#    I use this script to download
#    the LGCB book from web and generate
#    a all-in-one big html file
#    and then I can use htmldoc to
#    get a nice pdf
#    
#################################
book_url="http://happypeter.github.com/LGCB/book/"
OUTPUT_FILE=lgcb.html


for file in `ls ../book|grep .md|grep -v tmp`
do
    short_name=`echo $file|awk -F"." '{print $1}'`
    page_url=$book_url$short_name".html"
    wget $page_url >/dev/null
done

## now parse index to know who comes first
cp ../book/index.html .
echo """
<style media="screen" >
    /*this is very important for me*/
    pre { margin-left: 3% }

</style>
<title>Linux Guide for Chinese Beginners</title>
""" >$OUTPUT_FILE
partno=0   ## NO. of parts 
while read line
do
    echo $line |grep h2 &>/dev/null
    if [ "$?" = "0" ] 
    then
        
        part_name=$line
        tag_name=Part$(( ++partno ))
        echo $part_name|sed 's/<\/h2>//g'|sed "s/<h2>/$tag_name:/g" >>$OUTPUT_FILE
        # "<h2> partname </h2>" ->  "Part1:partname"
    fi
    echo $line |grep \<li\> &>/dev/null
    if [ "$?" = "0" ] 
    then
        page_name=`echo $line|grep -o [a-z1-9]*_.*.html`
        echo $page_name
        cat $page_name |sed '1,12d'|sed 'N;$!P;$!D;$d' >>$OUTPUT_FILE
        # delete the first 12 & last 2 lines of a file
        rm $page_name
    fi

done < index.html


cp -rf  ../book/images/ .
rm index.html

#################################
#
#    h1->h2  h2->h3
#    "<Part 1>" -> "<h1> Part 1:"
#    
#################################
# need to consider <h2 style=ccc>xxx</h2>, so we need:
sed -i 's/<h2/<h3/g' $OUTPUT_FILE
sed -i 's/h2>/h3>/g' $OUTPUT_FILE
sed -i 's/<h1/<h2/g' $OUTPUT_FILE
sed -i 's/h1>/h2>/g' $OUTPUT_FILE

# now "Part1:topic" -> "<h1>Part1:topic</h1>"
sed -i "s/Part[1-9]*:.*/<h1>&<h1>/g" $OUTPUT_FILE 

# use  htmldoc to generate a pdf, it looks really nice

