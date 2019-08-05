WORKDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
FILES_DIR := $(WORKDIR)/files

PRETTIER_EXECUTABLES := \
	npm
$(foreach exec,$(PRETTIER_EXECUTABLES),\
	$(if $(shell which $(exec)),,$(error No `$(exec)` in $$PATH)))

PRETTIER_VERSION := 1.18.2
PRETTIER_DIR := $(FILES_DIR)/prettier/$(PRETTIER_VERSION)
PRETTIER := $(PRETTIER_DIR)/node_modules/.bin/prettier

$(PRETTIER_DIR):
	mkdir --parent '$@'

$(PRETTIER): $(PRETTIER_DIR)
	npm \
		install \
		--no-save \
		--no-audit \
		--prefix '$(PRETTIER_DIR)' \
		'prettier@$(PRETTIER_VERSION)'
	chmod +x '$@'
	touch '$@'

.PHONY: install-prettier
install-prettier: $(PRETTIER)
