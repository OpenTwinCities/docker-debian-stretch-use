#!/bin/bash
# Parameter 1: abbreviation
# Parameter 2: Docker image
# Parameter 3: Docker container
# Parameters 4 and 5: 1st guest port number and corresponding host port number
# Parameters 6 and 7: 2nd guest port number and corresponding host port number
# Parameters 8 and 9: 3rd . . . .
# Parameters 10 and 11: . . . .

############################################
# BEGIN: setting environment variable inputs
############################################

ABBREV=$1
shift # $2 becomes the new $1, $3 becomes the new $2, etc.
DOCKER_IMAGE=$1
shift # $2 becomes the new $1, $3 becomes the new $2, etc.
CONTAINER=$1
shift # $2 becomes the new $1, $3 becomes the new $2, etc.

# Remaining parameters are port numbers

ARRAY_PORTS=() # NOTE: Always has an even number of elements
i=0
while [ $# -gt 1 ]; do # If the number of port numbers is odd, the last one is ignored.
  # ARRAY_PORTS+=($1 $2)
  ARRAY_PORTS[i]=$1
  ARRAY_PORTS[i+1]=$2
  shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  i=$((i+2))
done

# echo "All elements of ARRAY_PORTS: ${ARRAY_PORTS[@]}"
# echo "Number of elements in ARRAY_PORTS: ${#ARRAY_PORTS[@]}"

###############################################
# FINISHED: setting environment variable inputs
###############################################

################################################
# BEGIN: acquiring the scripts from the upstream 
# docker-debian-buster-use repository
#####################################

remove_dir () {
  DIR_TO_REMOVE=$1
  if [ -d $DIR_TO_REMOVE ]
  then 
    rm -rf $DIR_TO_REMOVE
  fi
}

remove_dir 'docker-debian-buster-use'
remove_dir 'templates_shared'
remove_dir 'templates_use'

echo '--------------------------------------------------------------------------'
echo 'git clone https://gitlab.com/rubyonracetracks/docker-debian-buster-use.git'
git clone https://gitlab.com/rubyonracetracks/docker-debian-buster-use.git
cp docker-debian-buster-use/setup.sh setup.sh
cp -r docker-debian-buster-use/templates_shared templates_shared
cp -r docker-debian-buster-use/templates_use templates_use
wait
remove_dir 'docker-debian-buster-use'

###################################################
# FINISHED: acquiring the scripts from the upstream 
# docker-debian-buster-use repository
#####################################

sh setup.sh $ABBREV $DOCKER_IMAGE $CONTAINER ${ARRAY_PORTS[@]}
