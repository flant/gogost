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
    --set-customization-variable DATE_IN_HEADER=1 \
    --set-customization-variable ASCII_PUNCTUATION=1 \
    --output $html www.texi
(
    cd $html
    export ATOM_ID="34c4c603-9fa7-4441-a089-881d216d8638"
    export NAME=GoGOST
    export BASE_URL=http://www.gogost.cypherpunks.ru
    export AUTHOR_EMAIL=gogost@cypherpunks.ru
    ~/work/releases-feed/releases.atom.zsh
)
perl -i -npe 'print "<link rel=\"alternate\" title=\"Releases\" href=\"releases.atom\" type=\"application/atom+xml\">\n" if /^<\/head>/' $html/Download.html
find $html -type d -exec chmod 755 {} +
find $html -type f -exec chmod 644 {} +
