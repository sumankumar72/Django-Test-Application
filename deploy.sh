#!/bin/sh

ssh school@35.200.226.107 <<EOF
 projname=test
 ssh_pass=Q7fvjcKGi5dxpZax
 git_branch=staging
 multi_tenant=0
 req_txt=requirements.txt
 proj_dir=/home/multi/order.nathabit/backend/www
 env_dir=/home/multi/order.nathabit/backend



 echo "project name =  \${projname}"

 exec_cmd()
    {
        cmd=\$1
        msg=\$2

        printf "\n***************** Executing // \$2 // ****************\n"
        if ! eval "\$1" ; then
            echo "ERROR:- \$2 FAILED"
            exit 2
        fi
        printf "\n***************** STATUS:- //\$2// COMPLETE**********\n"
    }

  source \${env_dir}/myenv/bin/activate
  cd \${proj_dir}

  exec_cmd "git pull origin \${git_branch}" "Git PULL"

  exec_cmd "pip install -r \${req_txt}" "PIP install REQs"

  if [[ \${multi_tenant} == 1 ]]; then
      exec_cmd "./manage.py migrate_schemas --executor=parallel" "Migrate Multi Schemas --executor=parallel"
    else
       exec_cmd "./manage.py migrate" "Migrate DB"
    fi

  exec_cmd "./manage.py collectstatic --noinput" "Collect Static"

  echo "\${ssh_pass}" | sudo -S systemctl restart \${projname}
  echo "Application $(whoami) restart sucessful"

  echo "DONE:- Deployment script executed sucessfully"

 exit

EOF
