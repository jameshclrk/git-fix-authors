#!/bin/bash

AUTHORS_FILE=authors.yml

NUM_AUTHORS=`cat ${AUTHORS_FILE} | shyaml get-values authors | grep name | wc -l`

for (( COUNTER=0; COUNTER<$NUM_AUTHORS; COUNTER+=1 )); do
    NAME=`cat ${AUTHORS_FILE} | shyaml get-value authors.$COUNTER.name`
    EMAIL=`cat ${AUTHORS_FILE} | shyaml get-value authors.$COUNTER.email`
    OLD_EMAILS=`cat ${AUTHORS_FILE} | shyaml get-values authors.$COUNTER.old_emails`
    echo $NAME
    for old_email in $OLD_EMAILS; do
        git filter-branch -f --env-filter '
            OLD_EMAIL="'"$old_email"'"
            CORRECT_NAME="'"$NAME"'"
            CORRECT_EMAIL="'"$EMAIL"'"
            if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
            then
                export GIT_COMMITTER_NAME="$CORRECT_NAME"
                export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
            fi
            if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
            then
                export GIT_AUTHOR_NAME="$CORRECT_NAME"
                export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
            fi
        ' --tag-name-filter cat -- --branches --tags
    done
done
