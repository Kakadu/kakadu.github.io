.PHONY: all
.SUFFIXES: .html .asciidoc .ml

# asciidoc bootstrap backed we get from https://github.com/llaville/asciidoc-bootstrap-backend
# unpack archive to get ~/.asciidoc/backends/asciidoc/bootstrap/bootstrap.conf

FILES_IN=$(shell ls *.asciidoc)
FILES_OUT=$(patsubst %.asciidoc,%.html,$(FILES_IN))
BACKEND=html5
#BACKEND=bootstrap
OPTS=theme=readable totop=ui linkcss sidebar=left icons iconsfont=font-awesome # iconsfont=glyphicon

all: $(FILES_OUT)

index.html: index.asciidoc
	asciidoctor -b $(BACKEND) $(addprefix -a ,$(OPTS)) $<

exercises%.html: exercises%.asciidoc
	asciidoctor -b $(BACKEND)  $<

celan: clean

clean:
	$(RM) $(FILES_OUT)
