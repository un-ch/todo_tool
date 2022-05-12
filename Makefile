BASHRC_FILE=$$HOME/.test_bashrc
DATA_FILE=$$HOME/.test_todo
DEALING_TODO_SCRIPT=$$HOME/.test_dealing_with_todo_tool_script.sh

# targets:
.PHONY: install
install:
	@touch $(DATA_FILE)
	@echo \#### todo_tool section: \#### >> $(BASHRC_FILE)
	@echo \# today task: >> $(BASHRC_FILE)
	@echo alias tod=\""grep -n '^0:' \$$DATA_FILE | cut -d':' -f1,3,4\"" >> $(BASHRC_FILE)
	@echo \# nextday task: >> $(BASHRC_FILE)
	@echo alias tom=\""grep -n '^1:' \$$DATA_FILE | cut -d':' -f1,3,4\"" >> $(BASHRC_FILE)
	@echo \# later task: >> $(BASHRC_FILE)
	@echo alias lat=\""grep -n '^!:' \$$DATA_FILE | cut -d':' -f1,3,4\"" >> $(BASHRC_FILE)
	@echo \# done task: >> $(BASHRC_FILE)
	@echo alias don=\""grep -n '^x:' \$$DATA_FILE | cut -d':' -f1,3,4\"" >> $(BASHRC_FILE)
	@echo \# dated task: >> $(BASHRC_FILE)
	@echo alias dat=\""grep -n '^[0-9][0-9]-[0-9][0-9]:|\
	[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]:' \$$DATA_FILE\"" >> $(BASHRC_FILE)
	@echo >> $(BASHRC_FILE)

	@echo function del\(\) >> $(BASHRC_FILE)
	@echo { >> $(BASHRC_FILE)
	@echo \	if [ \"\$$\1\" = \"\" ]\; then >> $(BASHRC_FILE)
	@echo \		echo \""error: no task number\""\; >> $(BASHRC_FILE)
	@echo \		return 1\; >> $(BASHRC_FILE)
	@echo \	fi\ >> $(BASHRC_FILE)
	@echo \	sed -i \"$$\1d\" \$$DATA_FILE\; >> $(BASHRC_FILE)
	@echo } >> $(BASHRC_FILE)
	@echo \#### end of todo_tool section: \#### >> $(BASHRC_FILE)

	@touch $(DEALING_TODO_SCRIPT)
	@echo DATA_FILE=$HOME/.todo >> $(DEALING_TODO_SCRIPT)
	@echo TODAY_DATE=$$\(date \"+%F\"\) >> $(DEALING_TODO_SCRIPT)
	@echo LAST_ACCESS_DATE_TO_DATA_FILE=$(grep LAST_ACCESS_DATE_TO_DATA_FILE $DATA_FILE | cut -d':' -f2) >> $(DEALING_TODO_SCRIPT)

	@echo if [ \"\$$LAST_ACCESS_DATE_TO_DATA_FILE\" = \"$$TODAY_DATE\" ]\; then
	@echo 	exit 1;
	@echo fi

	@echo TODAY_DATE=$(date "+%F" | cut -d'-' -f2,3)
	@echo NEXTDAY_DATE=$(date "+%F" --date="next day" | cut -d'-' -f2,3)

	@echo TODAY_TASK_LABEL=0
	@echo NEXT_DAY_TASK_LABEL=1
	@echo UNDATED_TASK_LABEL=!
	@echo DONE_TASK_LABEL=x

	@echo sed -i "s/^$DONE_TASK_LABEL:/$TODAY_TASK_LABEL:/g" $DATA_FILE
	@echo sed -i "s/^$NEXT_DAY_TASK_LABEL:/$TODAY_TASK_LABEL:/g" $DATA_FILE
	@echo sed -i "s/^$TODAY_DATE:/$TODAY_TASK_LABEL:/g" $DATA_FILE
	@echo sed -i "s/^$NEXTDAY_DATE:/$NEXT_DAY_TASK_LABEL:/g" $DATA_FILE

	@echo TODAY_DATE=$(date "+%F")
	@echo sed -i "1s/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/$TODAY_DATE/" $DATA_FILE
