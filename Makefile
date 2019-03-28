.PHONY: all
all: bin dotfiles

MAKEFILE_DIR=$(patsubst %/,%,$(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

BINFILES=$(shell find $(MAKEFILE_DIR)/bin -type f -not -name ".*.swp")

.PHONY: bin
bin: ## Installs the bin directory files.
	@echo "Linking binaries..."
	@mkdir -p $(HOME)/bin
	@- $(foreach BINFILE,$(BINFILES), \
		echo ln -sf $(BINFILE) $(HOME)/bin/$(notdir $(BINFILE)); \
		ln -sf $(BINFILE) $(HOME)/bin/$(notdir $(BINFILE)); \
	)

all-files-in-dir = $(foreach file,\
	$(wildcard $(1)/*),\
	$(file):$(patsubst $(1)/%,$(2)/%,$(file)))

# Default link target is $(HOME)/.$(name)
# Custom link target name may be provided after :
DOTFILES=Rprofile \
	 alacritty.yml:$(HOME)/.config/alacritty/alacritty.yml \
	 dictrc \
	 gitconfig \
	 gitignore \
	 $(call all-files-in-dir,gnupg,$(HOME)/.gnupg) \
	 procmail/proc-git-patches:$(HOME)/.procmail/proc-git-patches \
	 radare2rc \
	 ripgreprc \
	 ssh/config:$(HOME)/.ssh/config \
	 tmux.conf \
	 tmux.remote.conf \
	 vimrc \
	 vim/autoload/plug.vim:$(HOME)/.vim/autoload/plug.vim \
	 zshrc \
	 $(call all-files-in-dir,zsh,$(HOME)/.zsh) \
	 $(call all-files-in-dir,bat,$(HOME)/.bat)

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
	@echo "Linking dotfiles..."
	@chmod 600 $(MAKEFILE_DIR)/ssh/config
	@- $(foreach DOTFILE,$(DOTFILES), \
		$(eval source = $(word 1,$(subst :, ,$(DOTFILE)))) \
		$(eval target = $(word 2,$(subst :, ,$(DOTFILE)))) \
		\
		$(if $(target),$(shell mkdir -p $(dir $(target)))) \
		echo ln -sf $(MAKEFILE_DIR)/$(source) $(if $(target),$(target),$(HOME)/.$(source)); \
		rm -f $(if $(target),$(target),$(HOME)/.$(source)) && \
		ln -sf $(MAKEFILE_DIR)/$(source) $(if $(target),$(target),$(HOME)/.$(source)); \
	)

.PHONY: test
test: shellcheck ## Runs all tests.

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: shellcheck
shellcheck: ## Runs shellcheck tests on the scripts.
	@echo "Running shellcheck..."
	@docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(MAKEFILE_DIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
