all: gem

gem: libpasta
	cd libpasta && rake build && gem compile pkg/*
	cd pasta_rails && rake test	
