NAME = nexus
VERSION = 0.1
ARCHIVE=nexus.tar


build: package
	docker build --force-rm -t $(NAME):$(VERSION) -f Dockerfile . 
package: clean
	tar cvfz config.tar.gz config
	tar cvfz roles.tar.gz roles
clean:
	if [ -f $(ARCHIVE) ]; then rm $(ARCHIVE); fi
	if [ -f config.tar.gz ]; then rm config.tar.gz; fi
	if [ -f roles.tar.gz ]; then rm roles.tar.gz; fi
save: 
	docker save -o $(ARCHIVE) $(NAME):$(VERSION)
