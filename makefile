MAKEFILE = Makefile

FILES := $(filter-out $(MAKEFILE), $(wildcard *))

.PHONY: push
push:
	git status	
	git add $(FILES)
	git commit -m "in dev"
	git push
	git status
