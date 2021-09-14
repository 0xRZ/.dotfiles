SUBDIRS = ./i3blocks-contrib/bandwidth2
SUBDIRS += ./i3blocks-contrib/cpu_usage2
SUBDIRS += ./i3blocks-contrib/memory2

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: all $(SUBDIRS)
