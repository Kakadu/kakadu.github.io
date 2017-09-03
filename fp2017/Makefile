.PHONY: all
.SUFFIXES: .html .asciidoc .ml

# asciidoc bootstrap backed we get from https://github.com/llaville/asciidoc-bootstrap-backend
# unpack archive to get ~/.asciidoc/backends/asciidoc/bootstrap/bootstrap.conf


OPTS=theme=readable totop=ui linkcss sidebar=left icons iconsfont=font-awesome # iconsfont=glyphicon

all: index.html


index.html: index.asciidoc
	asciidoc -b bootstrap $(addprefix -a ,$(OPTS)) $<

celan: clean

clean:
	rm -f index.html

