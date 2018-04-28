.PHONY: all
all: bin dotfiles

MAKEFILE_DIR=$(patsubst %/,%,$(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

BINFILES=$(shell find $(MAKEFILE_DIR)/bin -type f -not -name ".*.swp")

.PHONY: bin
bin:
	@echo "Linking binaries..."
	@mkdir -p $(HOME)/bin
	@- $(foreach BINFILE,$(BINFILES), \
		echo ln -sf $(BINFILE) $(HOME)/bin/$(notdir $(BINFILE)); \
		ln -sf $(BINFILE) $(HOME)/bin/$(notdir $(BINFILE)); \
	)

# Default link target is $(HOME)/.$(name)
# Custom link target name may be provided after :
DOTFILES=Rprofile \
	 alacritty.yml:$(HOME)/.config/alacritty/alacritty.yml \
	 dictrc \
	 gitconfig \
	 gitignore_global \
	 gnupg/gpg.conf:$(HOME)/.gnupg/gpg.conf \
	 gnupg/gpg-agent.conf:$(HOME)/.gnupg/gpg-agent.conf \
	 procmail/proc-git-patches:$(HOME)/.procmail/proc-git-patches \
	 radare2rc \
	 ripgreprc \
	 ssh/config:$(HOME)/.ssh/config \
	 tmux.conf \
	 tmux.remote.conf \
	 vimrc \
	 vim/autoload/plug.vim:$(HOME)/.vim/autoload/plug.vim \
	 zshrc \
	 zsh/local-setup.zsh:$(HOME)/.zsh/local-setup.zsh

.PHONY: dotfiles
dotfiles:
	@echo "Linking dotfiles..."
	@chmod 600 $(MAKEFILE_DIR)/ssh/config
	@- $(foreach DOTFILE,$(DOTFILES), \
		$(eval source = $(word 1,$(subst :, ,$(DOTFILE)))) \
		$(eval target = $(word 2,$(subst :, ,$(DOTFILE)))) \
		\
		$(if $(target),$(shell mkdir -p $(dir $(target)))) \
		echo ln -sf $(MAKEFILE_DIR)/$(source) $(if $(target),$(target),$(HOME)/.$(source)); \
		ln -sf $(MAKEFILE_DIR)/$(source) $(if $(target),$(target),$(HOME)/.$(source)); \
	)

.PHONY: test
test: shellcheck

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: shellcheck
shellcheck:
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(MAKEFILE_DIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh
