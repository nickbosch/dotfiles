.PHONY: install simulate

install:
	stow -t ~ .

simulate:
	stow --simulate --verbose -t ~ .
