USER_EMOJIS=user_emoji.txt
ifeq ("$(wildcard $(USER_EMOJIS))","")
USER_EMOJIS=
endif

default: dmenu-emoji.sh

dmenu-emoji.sh: script.sh emoji.txt
	@echo "#!/bin/sh" > $@
	@echo "print_emojis() {" >> $@
	@echo "cat << EOF" >> $@
	@cat emoji.txt >> $@
	@echo "EOF" >> $@
	@echo "}" >> $@
	@cat script.sh >> $@
	@chmod +x $@
	@du -sh $@

emoji.txt: emoji.json parse.sh  ${USER_EMOJIS}
	@sh parse.sh < emoji.json > $@

emoji.json:
	@echo "Downloading emoji table from https://github.com/github/gemoji (Emoji Ruby gem)"
	@echo
	@curl https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json > $@
	@echo

.PHONY: update
update: clean default

.PHONY: clean
clean:
	@rm -f emoji.json emoji.txt
