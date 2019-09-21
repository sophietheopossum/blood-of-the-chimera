#!/bin/bash
git add *
read -p "commit message: " MSG
git commit -m "${MSG}"
git push origin master
