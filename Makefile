###############################################################################
#                                                                             #
# Romain Dorgueil's environment Makefile.                                     #
#                                                                             #
# make clean && make will get you a useable working copy.                     #
# make everything (HARMFULL) will destroy and replace current user's env.     #
#                                                                             #
###############################################################################

.PHONY: all clean submodules install everything update pull

all: submodules bin vim
everything: clean install
update: pull submodules

bin:
	@echo ">>> Building local binary directory."
	@local/bin/lntree "local/bin vendor/bin-git-utils" "bin" "../"

vim:
	@echo ">>> Building .vim directory from vendor and local files."
	@rm -rf vim.tmp
	@cp -ra local/vim vim.tmp
	@cp -ra vendor/vim-snipmate/* vim.tmp/
	@cp -ra local/vim-snipmate/* vim.tmp/
	@mv vim.tmp vim

clean:
	@echo ">>> Cleaning git submodules..."
	@git submodule|awk '{print $2}'|xargs rm -rf
	@echo ">>> Cleaning bin directory..."
	@rm -rf bin
	@echo ">>> Cleaning vim directory..."
	@rm -rf vim vim.tmp
	@echo ">>> Done."

pull:
	@echo ">>> Pulling master..."
	@git pull git://github.com/hartym/env master

submodules:
	@echo ">>> Fetching git submodules."
	@git submodule init > /dev/null
	@git submodule update > /dev/null

install: all
	@echo ">>> Searching/destroying/replacing local user environment ..."
	@local/bin/install-rd-env

