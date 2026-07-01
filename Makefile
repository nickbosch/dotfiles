.PHONY: install simulate

install:
	stow --verbose --no-folding -t ~ .

simulate:
	stow --simulate --verbose --no-folding -t ~ .
