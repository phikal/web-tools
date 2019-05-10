# a blog parser using gawk - philip k., 2018

# all markdown files have to be specified as command line
# arguments. only those with a comment containing a unix timestamp (and
# optionally tags), and a h1 header will part of the feed.

BEGIN { OFS = "\t" }

/^<!--@ [[:digit:]]+ (.+ )?-->$/ {
	 sub(/^<!--@ /, "")
	 sub(/ -->$/, "")
	 date = $1

	 for (i = 2; i <= NF; i++)
		  cat = cat "\t" $i
}

/^# / && !title {
	 sub(/^# /, "")
	 gsub(/\t/, " ")
	 title = $0
}

NR == 10 { nextfile }

ENDFILE {
	 if (date) {
		  sub(/^(.*\/)?md\/txt\//, "", FILENAME)
		  sub(/.md$/, "", FILENAME)
		  print title, date, FILENAME, cat
	 }

	 cat = ""
	 title = ""
	 date = 0
}
