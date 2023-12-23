#!/usr/bin/bash

banner='[LUIS-TOOLBOX]'
warn='[warning]'
fail='[failure]'
succ='[success]'

cd $PWD/script/interactive

PS3="Your choice: "

files="$(ls -rt .)"

echo "-------------------------------------------"
echo " Luisadha Interactive Script Toolbox"
echo " version : v1.1 "
echo "-------------------------------------------"
echo -e "Provide some tools from repository:\n Visit https://github.co
m/luisadha/luisadha"
echo

select filename in ${files} Quit "Add repository";
do
[[ -n $filename ]] || { echo "$warn :What's that? Please try again." >
&2; continue; }

  case ${filename} in
    "Quit")
      echo "Exiting.."
      break
      ;;
    "Add repository")
      echo "$banner : Paste your repository link below :"
      read REPO_LINK
       if timeout 10s ping -c 1 google.com &> /dev/null; then
         if [ -z $REPO_LINK ]; then
           echo "$warn : Broken link."
           exit 1
         fi
         REPO_FOLDER=$(basename "$REPO_LINK" .git)
         if git clone "$REPO_LINK.git" "$REPO_FOLDER"; then
         echo "$succ : Repo's was completly cloned, please refresh!"
       else
         echo "$fail : Unable to clone the repository, please correct
the names. "
         exit 1
         fi
       else
           echo "$fail : Couldn't connected to internet!, Abort."

           break
        fi
      break
      ;;
    *)
        echo "You selected $filename ($REPLY)"
    echo
      chmod +x ${filename}/${filename,,}.sh
      ./${filename}/${filename,,}.sh
    echo
     read -t 0.1
     continue
     ;;
  esac
done
