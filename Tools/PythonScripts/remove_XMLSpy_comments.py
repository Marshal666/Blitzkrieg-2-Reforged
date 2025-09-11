import os, re

regexp = re.compile( "<!-- edited with XMLSPY [^}]* -->" );
for (dirpath, dirnames, filenames) in os.walk("./Versions/Current"):
	files = filter( lambda x: re.match(r".*\.xml", x), filenames )
	for i in files:
		filename = dirpath + "/" + i

		print "Cleaning: ", filename

		file = open(filename)
		data = file.read()
		file.close()
		data = regexp.sub( "", data )

		file = open(filename, "w+")
		file.write(data)
		file.close()
