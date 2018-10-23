
PARENT="test/assets"
PATTERN="*.html"


echo "<html><body><ul>" > $PARENT/summary.html
for f in $(find $PARENT -name "$PATTERN" ); do 
	echo "<li><a href=\"$f\">$f</a></li>" >> $PARENT/summary.html
done

echo "</ul></body></html>" >> $PARENT/summary.html