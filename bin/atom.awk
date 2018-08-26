# an atom feed generator using gawk - philip k., 2018
# written in accordance to https://validator.w3.org/feed/docs/atom.html

# all markdown files have to be specified as command line
# arguments. only those with a comment containing a unix timestamp (and
# optionally tags), and a h1 header will part of the feed.

BEGIN {
	 TITLE = "~phi/txt feed"
	 PATH  = "/txt"
	 EMAIL = "philip@warpmail.net"
	 HOMEP = "zge.us.to"
	 NAME  = "Philip K."

	 FS = "\t"
	 RFC3339 = "%Y-%m-%dT%H:%M:%SZ"

	 print "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	 print "<feed xmlns=\"http://www.w3.org/2005/Atom\">"

	 printf xml("title", TITLE)
	 printf xml("rights", "Public Domain")
	 printf xml("generator", "zge's atom.awk")
	 printf xml("id", "https://" HOMEP "/")
	 printf xml("author",						\
				xml("name", NAME)				\
				xml("email", EMAIL)				\
				xml("uri", "https://" HOMEP))

	 link["rel"] = "self"
	 link["href"] = "https://" HOMEP PATH "/atom.xml"
	 printf xml("link", "", link)

	 link["rel"] = "alternate"
	 link["href"] = "https://" HOMEP PATH "/"
	 link["type"] = "text/html"
	 delete link["type"]

	 link["rel"] = "alternate"
}


function xml(tag, content, attr) {
	 str = "<" tag

	 for (key in attr)
		  str = str " " key "=\"" attr[key] "\""

	 if (!content) str = str " />"
	 else  {
		  if (content ~ /^</)
			   str = str ">\n"
		  else {
			   str = str ">"

			   # https://www.w3.org/TR/xml/#dt-escape
			   gsub(/&/, "\\&amp;", content)
			   gsub(/>/, "\\&lt;", content)
			   gsub(/</, "\\&lt;", content)
			   gsub(/'/, "\\&apos;", content)
			   gsub(/"/, "\\&quot;", content)
		  }

		  str = str content "</" tag ">"
	 }

	 return str "\n"
}

!head {
	 print xml("updated", strftime(RFC3339, $2))
	 head = !head
}

{
	 link["href"] = "https://" HOMEP PATH "/" $3 ".html"

	 print "<entry>"
	 print xml("title", $1)
	 print xml("updated", strftime(RFC3339, $2))
	 print xml("id", "tag:" HOMEP "," strftime("%F", $2) ":/" $3)
	 print xml("link", "", link)
	 for (i = 5; i <= NF; i++) {
		  category["term"] = $i
		  print xml("category", "", category)
	 }
	 print "<content type=\"html\">"
	 system("sed 1d md/txt/" $3 ".md | cmark --normalize | sed 's_&_\\&amp;_g; s_<_\\&lt;_g; s_>_\\&gt;_g'")
	 print "</content>"
	 print "</entry>"
}

END { print "</feed>" }
