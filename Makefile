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
	@usr/local/bin/lntree "usr/local/bin usr/share/git-utils/bin usr/share/git-flow/bin usr/share/git-hg/bin" "build/bin" "../../"

vim:
	@echo ">>> Building .vim directory from vendor and local files."
	@rm -rf vim.tmp
	@cp -ra usr/local/vim/base vim.tmp
	@cp -ra usr/share/vim/snipmate/* vim.tmp/
	@cp -ra usr/share/vim/git/* vim.tmp/
	@cp -ra usr/local/vim/snipmate/* vim.tmp/
	@cp -ra usr/local/vim/phpdoc/* vim.tmp/
	@mv vim.tmp build/vim

clean:
	@echo ">>> Cleaning git submodules..."
	@for sub in `git submodule|awk '{print $2}'`; do rm -rf $sub; done
	@echo ">>> Cleaning build directory..."
	@rm -rf build
	@echo ">>> Done."

pull:
	@echo ">>> Pulling master..."
	@git pull git://github.com/hartym/env master

submodules:
	@echo ">>> Fetching git submodules."
	@git submodule init > /dev/null
	@git submodule update --init --recursive > /dev/null

install: all
	@echo ">>> Searching/destroying/replacing local user environment ..."
	@usr/local/bin/install-rd-env

