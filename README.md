# Helper commands for the unofficial OXID_Docker_Stack
Helper commands for the unofficial [OXID_Docker_Stackv2](https://github.com/OXIDFabian/OXID_Docker_Stackv2) from [OXIDFabian](https://github.com/OXIDFabian/)

### Install
Copy the content from the file [.bashrc](https://github.com/michaelkeiluweit/linux-docker-helper/blob/master/.bashrc) into your very own .bashrc file.   
Be aware to adapt the path to the phpstorm executeable `(nohup /usr/local/bin/pstorm .  >/dev/null 2>&1 &)` according to your own system. It is helpful to install the [Intellij Toolbox-App](https://www.jetbrains.com/de-de/toolbox-app/) since it can provide you the correct path to PHPStorm.  

Copy the directory [docker_config](https://github.com/michaelkeiluweit/linux-docker-helper/tree/master/docker_config) to your home directory, next to the .bashrc file.
Be aware that the functions from the file .bashrc are searching for this folder in the home directory.
 
Adjust the content from the files which are located in docker_config to your own needs.   
- `.env` The Docker stack brings its own file, so the user can adjust the environment to the own needs. In my case the file often needs the same adjustments, so I wrote one final .env file which then replaces the file from the Docker stack repository automatically.
- `auth.json` This file is read by composer in case of credentials are needed to download a package. Since I don't want to enter each time the same credentials, this file replaces the one from the Docker stack repository,
Open a new shell to be able to use the commands.

### Commands

- `doxid <directory name>`  
  Creates a new directory with the given name and switches your context into it.  
  Downloads the latest version of the  OXID_Docker_Stackv2 repository.  
  As next step it takes the files from the directory docker_config and replaces the ones from the repository.  
  Tries to start PHPStorm with the current context in mind.  
  
- `dstart`  
  Assumes your context is the root directory of the new project, basically where the command `doxid` brought you to.  
  The root directory is recognizable by the files "docker-compose.yml", ".env", "auth.json" and the folders "config", "data".
  
- `dlogs`  
  Creates a new shell session, connects to the php container and executes the log command (like `tail -f`).
  
- `dlogin`  
  Creates a new shell session and connects to the php container.
  
- `dstop`  
  stops all running conainers

## Mac
Since the performance of the volumes are way too slow to work with, another tool is needed to increase the speed: docker-sync.  
How to install docker sync: https://github.com/michaelkeiluweit/OXID_Docker_Stackv2_4Mac. 
Always use `dstart` to boot a container, since `docker-compose up` doesn't include the necessary docker-comopose.dev.yml file and docker-sync wan't work correctly.
