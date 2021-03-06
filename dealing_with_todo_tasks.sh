#!/bin/bash

DATA_FILE=/home/us/todo
TODAY_DATE=$(date "+%F")
LAST_ACCESS_DATE_TO_DATA_FILE=$(grep LAST_ACCESS_DATE_TO_DATA_FILE $DATA_FILE | cut -d':' -f2)

if [ "$LAST_ACCESS_DATE_TO_DATA_FILE" = "$TODAY_DATE" ]; then
	exit 1;
fi

TODAY_DATE=$(date "+%F" | cut -d'-' -f2,3)
NEXTDAY_DATE=$(date "+%F" --date="next day" | cut -d'-' -f2,3)

TODAY_TASK_LABEL=0
NEXT_DAY_TASK_LABEL=1
NEXT_DAY_AFTER_TOMORROW_LABEL=2
UNDATED_TASK_LABEL=!
DONE_TASK_LABEL=x

sed -i "s/^$DONE_TASK_LABEL:/$TODAY_TASK_LABEL:/g" $DATA_FILE
sed -i "s/^$NEXT_DAY_TASK_LABEL:/$TODAY_TASK_LABEL:/g" $DATA_FILE
sed -i "s/^$NEXT_DAY_AFTER_TOMORROW_LABEL:/$NEXT_DAY_TASK_LABEL:/g" $DATA_FILE

sed -i "s/^$TODAY_DATE:/$TODAY_TASK_LABEL:/g" $DATA_FILE
sed -i "s/^$NEXTDAY_DATE:/$NEXT_DAY_TASK_LABEL:/g" $DATA_FILE

TODAY_DATE=$(date "+%F")
sed -i "1s/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/$TODAY_DATE/" $DATA_FILE
