.PHONY: all
.SUFFIXES: .html .asciidoc .ml

# asciidoc bootstrap backed we get from https://github.com/llaville/asciidoc-bootstrap-backend
# unpack archive to get ~/.asciidoc/backends/asciidoc/bootstrap/bootstrap.conf

FILES_IN=$(shell ls *.asciidoc)
FILES_OUT=$(patsubst %.asciidoc,%.html,$(FILES_IN))
BACKEND=html5
OPTS=theme=readable totop=ui linkcss sidebar=left icons iconsfont=font-awesome # iconsfont=glyphicon

all: $(FILES_OUT)

#index.html: index.asciidoc
#	asciidoctor -b $(BACKEND) $(addprefix -a ,$(OPTS)) $<

%.html: %.asciidoc
	asciidoctor -b $(BACKEND)  $<

celan: clean

clean:
	$(RM) $(FILES_OUT)

.PHONY: deps dev-deps watch
dev-deps:
	sudo apt install ruby-dev ruby-ffi ruby-http-parser
	GEM_HOME=$(HOME)/.gem gem install bundler jekyll
	GEM_HOME=$(HOME)/.gem PATH=$(HOME)/.gem/bin:$(PATH) bundle install

# Only repo packaged
deps:
	sudo apt install --yes --no-install-recommends \
		ruby-dev ruby-ffi ruby-http-parser ruby-jekyll-redirect-from jekyll-theme-minima jekyll

watch:
	@#GEM_HOME=$(HOME)/.gem PATH=$(HOME)/.gem/bin:$(PATH) bundle exec
	bundle exec jekyll serve --livereload
