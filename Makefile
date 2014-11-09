CONFIG=Makefile.config

include $(CONFIG)

default: build

build:

	# Init script
	for file in \
		etc/init/bloonix-webgui \
		etc/init/bloonix-webgui.service \
	; do \
		cp $$file.in $$file; \
		sed -i "s!@@USRLIBDIR@@!$(USRLIBDIR)!g" $$file; \
		sed -i "s!@@CACHEDIR@@!$(CACHEDIR)!g" $$file; \
		sed -i "s!@@CONFDIR@@!$(CONFDIR)!g" $$file; \
		sed -i "s!@@RUNDIR@@!$(RUNDIR)!g" $$file; \
		sed -i "s!@@SRVDIR@@!$(SRVDIR)!g" $$file; \
		sed -i "s!@@LOGDIR@@!$(LOGDIR)!g" $$file; \
	done;

test:

install:

	./install-sh -d -m 0755 $(USRLIBDIR)/bloonix/etc/webgui;
	./install-sh -c -m 0644 etc/bloonix/webgui/main.conf $(USRLIBDIR)/bloonix/etc/webgui/main.conf;
	./install-sh -c -m 0644 etc/bloonix/webgui/nginx.conf $(USRLIBDIR)/bloonix/etc/webgui/nginx.conf;

	./install-sh -d -m 0755 $(USRLIBDIR)/bloonix/etc/init.d;
	./install-sh -c -m 0755 etc/init/bloonix-webgui $(USRLIBDIR)/bloonix/etc/init.d/bloonix-webgui;

	./install-sh -d -m 0755 $(USRLIBDIR)/bloonix/etc/systemd;
	./install-sh -c -m 0755 etc/init/bloonix-webgui.service $(USRLIBDIR)/bloonix/etc/systemd/bloonix-webgui.service;

	if test -d /usr/lib/systemd/system ; then \
		./install-sh -c -m 0644 etc/init/bloonix-webgui.service /usr/lib/systemd/system/; \
	elif test -d /etc/init.d ; then \
		./install-sh -c -m 0755 etc/init/bloonix-webgui $(INITDIR)/bloonix-webgui; \
	fi;

	if test "$(BUILDPKG)" = "0" ; then \
		if test ! -e "$(CONFDIR)/bloonix/webgui/main.conf" ; then \
			./install-sh -c -m 0640 -o $(USERNAME) -g $(GROUPNAME) etc/bloonix/webgui/main.conf $(CONFDIR)/bloonix/webgui/main.conf; \
		fi; \
	fi;

clean:
