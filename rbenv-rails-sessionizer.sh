#!/bin/bash

ABBREV='rbenv-rails-sessionizer'
OWNER='jhsu802701'
DISTRO='debian'
SUITE='stretch'
DOCKER_IMAGE="registry.gitlab.com/$OWNER/docker-$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-$DISTRO-$SUITE-$ABBREV"

echo 'By default, your host port numbers are:'
echo '  MailCatcher: 1080'
echo '  Rails web server: 3000'
echo '  PostgreSQL: 15432'
echo
echo 'If you wish to work with multiple Docker images, you need to use a'
echo 'different offset for each one in order to avoid conflicts.'
echo
echo 'Enter the desired offset for your port numbers.'
read OFFSET

P1080=$(( 1080+OFFSET ))
P3000=$(( 3000+OFFSET ))
P5432=$(( 15432+OFFSET ))

bash setup-other.sh $ABBREV $DOCKER_IMAGE $CONTAINER $P1080 '1080' $P3000 '3000' $P5432 '5432'
