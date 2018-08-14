BEGIN {
	 if (ARGV[1] ~ /^doc/) doc = 1
	 else if (ARGV[1] ~ /^gal/) gal = 1
	 else {
		  print "invalid mode: either 'gal' or 'doc'" > "/dev/stderr"
		  exit 1
	 }

	 if (!section) {
		  print "'section' not specified" > "/dev/stderr"
		  exit 1
	 }

	 FS="\t+"
}

/^\s*$/ && body { next }

/^\s*$/ && !body {
	body = 1

	if (doc)
		 print "# **Documents:** " title[section] "\n"
	else if (gal)
		 print "# **Gallery:** " title[section] "\n"

	print descr[section] "\n"
	print ""
	print "<ul id=\"grid\">"
}

# section title description
!body && NR > 0 {
	title[$1] = $2
	descr[$1] = $3
}

{ $2 = (doc ? "pdf" : (gal ? "img" : "")) "/" $2 }

# section filename title description hover
body && section == $1 && NR >= 3 {
	tmb = $2

	print "<li>"
	print "<a href=\"/" $2 "\">"
	print "<img src=\"/tmb/" tmb "\" alt=\"" ($6 ? $6 : "-") "\"/>"
	print "</a>"
	print "<h2>" $3 "</h2>"
	print "<p>" $4 "</p>"
	print "</li>"
}

END { print "</ul>" }
