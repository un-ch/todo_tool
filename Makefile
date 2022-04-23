BASHRC_FILE=~/.test_bashrc
DATA_FILE=~/.test_todo

# targets:
.PHONY: install
install:
	@touch $(DATA_FILE)
	@touch $(BASHRC_FILE)
	@echo \# today task: >> $(BASHRC_FILE)
	@echo alias tod='grep -n "^0:" $$DATA_FILE | cut -d':' -f1,3,4' >> $(BASHRC_FILE)
	@echo \# nextday task: >> $(BASHRC_FILE)
	@echo alias tom='grep -n "^1:" $$DATA_FILE | cut -d':' -f1,3,4' >> $(BASHRC_FILE)
	@echo \# later task: >> $(BASHRC_FILE)
	@echo alias lat='grep -n "^!:" $$DATA_FILE | cut -d':' -f1,3,4' >> $(BASHRC_FILE)
	@echo \# done task: >> $(BASHRC_FILE)
	@echo alias don='grep -n "^x:" $$DATA_FILE | cut -d':' -f1,3,4' >> $(BASHRC_FILE)
	@echo \# dated task: >> $(BASHRC_FILE)
	@echo alias dat='grep -n "^[0-9][0-9]-[0-9][0-9]:|\
	[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]:" $$DATA_FILE'\ >> $(BASHRC_FILE)
