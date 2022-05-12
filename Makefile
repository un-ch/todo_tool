BASHRC_FILE=$$HOME/.bashrc
BASHRC_FILE_BACKUP=$$HOME/bashrc.bak
DATA_TODO_FILE=$$HOME/todo

DEALING_TODO_SCRIPT=dealing_with_todo_tasks.sh
ADDITION_TO_BASHRC_FILE=addition_to_bashrc_file

# targets:
.PHONY: install
install:
	@touch $(DATA_TODO_FILE)
	@cp $(BASHRC_FILE) $(BASHRC_FILE_BACKUP)
	@cat $(ADDITION_TO_BASHRC_FILE) >> $(BASHRC_FILE)
	@cp $(DEALING_TODO_SCRIPT) $$HOME
