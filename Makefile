###############################################################################
#                                                                             #
# Romain Dorgueil's environment Makefile.                                     #
#                                                                             #
# make (HARMFULL) will destroy and replace current user's env.                #
#                                                                             #
###############################################################################

.PHONY: all clean submodules install update pull

all: clean install
update: pull submodules

bin:
	@echo ">>> Building local binary directory."
	@rm -rf build/bin
	@usr/local/bin/lntree "usr/local/bin usr/share/git-utils/bin usr/share/git-ps1 usr/share/z" "build/bin" "../../"

vim:
	@echo ">>> Building .vim directory from vendor and local files."
	@rm -rf vim.tmp build/vim
	@cp -Ra usr/local/vim/base vim.tmp
	@echo "  > Compiling shared vim extensions"
	@cp -Ra usr/share/vim/git/* vim.tmp/
	@cp -Ra usr/share/vim/snipmate/* vim.tmp/
	@cp -Ra usr/share/vim/nerdtree/* vim.tmp/
	@cp -Ra usr/share/vim/nerdtree-tabs/* vim.tmp/
	@cp -Ra usr/share/vim/sparkup/* vim.tmp/
	cp -Ra usr/local/vim/jinja/* vim.tmp/
	mv vim.tmp build/vim

clean:
	@echo ">>> Cleaning git submodules..."
	@for sub in `git submodule|awk '{print $2}'`; do rm -rf $sub; done
	@echo ">>> Cleaning build directory..."
	rm -rf build
	@echo ">>> Done."

pull:
	@echo ">>> Pulling master..."
	git pull origin master

submodules:
	@echo ">>> Fetching git submodules."
	@git submodule init > /dev/null
	@git submodule update --init --recursive > /dev/null

install: update submodules bin vim
	@echo ">>> Searching/destroying/replacing local user environment ..."
	@usr/local/bin/install-rd-env

update: pull

