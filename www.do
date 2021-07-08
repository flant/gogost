redo-ifchange *.texi VERSION
html=gogost.html
rm -f $html/*.html
${MAKEINFO:-makeinfo} --html \
    -D "VERSION `cat VERSION`" \
    --css-include style.css \
    --set-customization-variable SECTION_NAME_IN_TITLE=1 \
    --set-customization-variable TREE_TRANSFORMATIONS=complete_tree_nodes_menus \
    --set-customization-variable FORMAT_MENU=menu \
    --set-customization-variable EXTRA_HEAD='<link rev="made" href="mailto:webmaster@cypherpunks.ru">' \
    --set-customization-variable SHOW_TITLE=0 \
    --set-customization-variable DATE_IN_HEADER=1 \
    --set-customization-variable TOP_NODE_UP_URL=index.html \
    --set-customization-variable CLOSE_QUOTE_SYMBOL=\" \
    --set-customization-variable OPEN_QUOTE_SYMBOL=\" \
    -o $html www.texi
find $html -type d -exec chmod 755 {} \;
find $html -type f -exec chmod 644 {} \;
