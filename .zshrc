function doxid {

    export name="$1";
    targetpath=~/Development/$name
    repository=https://github.com/OXIDFabian/OXID_Docker_Stackv2.git

    dstop

    git clone $repository $targetpath
    echo "Created directory:" $targetpath
    cd $targetpath

    mkdir data && mkdir data/www && mkdir data/mysql
    
    # docker-sync
    echo "Checking out docker-sync files."
    mkdir docker-sync
    git clone https://github.com/michaelkeiluweit/OXID_Docker_Stackv2_4Mac.git docker-sync
    cp docker-sync/docker-compose.yml docker-sync/docker-compose-dev.yml docker-sync/docker-sync.yml ./

    sed -i '' 's/db-sync/db-sync-'"${name}"'/g' docker-sync.yml
    sed -i '' 's/db-sync/db-sync-'"${name}"'/g' docker-compose-dev.yml
    
    sed -i '' 's/php-www-sync/php-www-sync-'"${name}"'/g' docker-sync.yml
    sed -i '' 's/php-www-sync/php-www-sync-'"${name}"'/g' docker-compose-dev.yml

    echo "Copy default docker configuration"
    cp ~/docker_config/.env $targetpath
    cp ~/docker_config/auth.json $targetpath

    #echo "open PHPStorm"
    #(nohup /usr/local/bin/pstorm .  >/dev/null 2>&1 &)

    echo "done."
}

function dstop {
    echo "Stopping ongoing docker images...";
    docker ps -aq | xargs docker stop $(docker ps -a -q)
    wait $!
   
    #docker network prune -f;
   
    #docker-sync stop
}


function dstart {
    echo "Boot docker containers..."

    #docker-compose up -d --force-recreate
    docker-sync start
    docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
    
    #echo "Start PHPStorm"
    #(nohup phpstorm .  >/dev/null 2>&1 &)
    #dlogin
}

function dlogin {
    #echo "Switch context to docker container php"
    #docker-compose exec php bash
    #gnome-terminal -- bash -c "docker-compose exec php bash;bash"
}

function dlogs {
    docker-compose logs -f php
}
