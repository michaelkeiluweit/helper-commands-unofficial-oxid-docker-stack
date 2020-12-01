export PATH=~/bin/:$PATH

function doxid {

    export name="$1";
    targetpath=/var/www/$name
    repository=https://github.com/OXIDFabian/OXID_Docker_Stackv2.git


#    echo "Stopping ongoing docker images...";
    dstop

    git clone $repository $targetpath
    echo "Created directory:" $targetpath
    cd $targetpath

    echo "Copy default docker configuration"
    cp ~/docker_config/.env $targetpath
    cp ~/docker_config/auth.json $targetpath

    echo "open PHPStorm"
    (nohup /usr/local/bin/pstorm .  >/dev/null 2>&1 &)

    echo "done."
}

function dstop {
    echo "Stopping ongoing docker images...";
    docker ps -aq | xargs --no-run-if-empty docker stop $(docker ps -a -q);
    docker ps -aq | xargs --no-run-if-empty docker rm $(docker ps -a -q);
}

function dstart {
    echo "Boot the docker containers..."
    docker-compose up -d
    echo "Start PHPStorm"
    (nohup /usr/local/bin/pstorm .  >/dev/null 2>&1 &)
    dlogin
}

function dlogin {
    echo "Switch context to docker container php"
    #docker-compose exec php bash
    gnome-terminal -- bash -c "docker-compose exec php bash;bash"
}

function dlogs {
    docker-compose logs -f php
}

