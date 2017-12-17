all: gem

libpasta-sync:
	git submodule update --init --recursive
ifneq ($(shell git -C libpasta/ext/pasta-bindings/ rev-parse --abbrev-ref HEAD),master)
	cd libpasta/ext/pasta-bindings && git fetch && git checkout origin/master
endif
	make -C libpasta/ext/pasta-bindings libpasta-sync

gem: libpasta-sync
	cd libpasta && rake build && gem compile pkg/*
	cd pasta_rails && rake test	

.PHONY: libpasta-sync
