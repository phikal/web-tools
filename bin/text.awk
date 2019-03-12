/^<!-- [[:digit:]]+ / && $(NF - 1) == "-->" {
	date = $2

	for (i = 2; i < NF - 1; i++) {
		if ($i ~ /^:/) {
			sub(/^:/, "", $i);
			plist[$i] = 1;
		} else if ($i ~ /^=/) {
			sub(/^=/, "", $i);
			plist[$i] = $(++i);
			if (i >= NF - 1)	# no value
				exit 1;
		}
	}

	next;
}

/^# / && head {
	title = gensub(/^# /, "", 1, $0);
	while ((getline line < head) > 0) {
		if (line ~ /%TITLE%/) {
			if ("title" in plist)
				print "<title>" plist["title"] "</title>"
			else if (title)
				print "<title>" title "</title>\n"
		} else if (line ~ /%SYNTAX%/) {
			print "<!-- highlight.js: https://highlightjs.org/ -->"
			print "<link rel=\"stylesheet\" href=\"/hl/default.css\">"
			print "<script src=\"/hl/highlight.js\"></script>"
			print "<script>"
			print "hljs.configure({ tabReplace: '    ' })"
			print "hljs.initHighlightingOnLoad();"
			print "</script>"
		} else if (line ~ /%LINKS%/) {
			if ("next" in plist)
				printf("<link rel=\"next\" href=\"%s\">", plist["next"]);
			if ("prev" in plist)
				printf("<link rel=\"prev\" href=\"%s\">", plist["prev"]);
			if ("first" in plist)
				printf("<link rel=\"first\" href=\"%s\">", plist["first"]);
			if ("last" in plist)
				printf("<link rel=\"last\" href=\"%s\">", plist["last"]);
		} else print line;
	}

	print "\n# " title

	if (date) print "\n<time>" strftime("%F", date) "</time>";

	head = 0

	next;
}

1

END { while ((getline < tail) > 0) print; } # print bottom of page
