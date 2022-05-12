BASHRC_FILE=$$HOME/.bashrc
DATA_TODO_FILE=$$HOME/todo

DEALING_TODO_SCRIPT=dealing_with_todo_tasks.sh
ADDITION_TO_BASHRC_FILE=addition_to_bashrc_file

# targets:
.PHONY: install
install:
	@touch $(DATA_TODO_FILE)
	@cat $(ADDITION_TO_BASHRC_FILE) >> $(BASHRC_FILE)
	@cp $(DEALING_TODO_SCRIPT) $$HOME
