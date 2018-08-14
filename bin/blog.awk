BEGIN { OFS = "\t" }

/^<!-- [[:digit:]]+ (.+ )?-->$/ {
	 sub(/^<!-- /, "")
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
