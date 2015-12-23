Recently I wanted to run automated backups of the project's [Nexus](http://www.sonatype.org/nexus/) and [Jenkins](https://jenkins-ci.org/) servers and store these backups in [AWS s3](https://aws.amazon.com/s3/?nc2=h_ls)

Here is what you have to do to achieve a similar goal.

#### Setting up AWS cli
First things first, so let's start by setting up the AWS command line interface (AWS cli). Basically I followed the steps that are discribed in this [post](http://alestic.com/2013/08/awscli). In brief:

1. Install python-pip:  
`sudo apt-get install -y python-pip`
2. Install awscli:
`sudo pip install awscli`
3. Create a folder that will contain the AWS config file:
`mkdir ~/.aws`  
`touch ~/.aws/config`  
`chmod 600 $HOME/.aws/config`
4. Next you need to edit the config file using your preferred editor and provide the access keys. My config file looks like this. Of course I did not enter my access keys. ;-)
```
[default]
aws_access_key_id = <access key id>
aws_secret_access_key = <secret access key>
region = eu-west-1
output=json
```
You also can add `export AWS_CONFIG_FILE=$HOME/.aws/config` to ~/.bashrc file but it's optional.
To check that everything is working correctly:    
`aws ec2 describe-regions`

Note that you can also setup AWS cli differently, then I did it. For example you can use `aws configure` to create the config file or split the config and the credentials into separated files. More information can be found in the official [AWS userguide](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

#### The backup script
The backup script is very individual and depends on the system or the files you want to backup. To backup a jenkins CI server I use the following script (backup.sh):
```
#!/bin/bash

TIMESTAMP=`date "+%Y%m%d-%H%M"`
TAR_NAME=jenkins_files_${TIMESTAMP}.tar.gz

tar cvfz ${TAR_NAME} jenkins_files --exclude='.cache' --exclude='.npm' --exclude='.m2' --exclude='node_modules' --exclude='.git'
/usr/local/bin/aws s3 mv ./${TAR_NAME} s3://<path-to-aws-bucket>

```
The most important part in this script is the last line. Here the created tar.gz archive is moved to aws s3. If you want to run the script manually it is sufficient to write `aws s3 mv ...`. But if you want to run this script using a cronjob you have to call aws with the fully qualified path. Otherwise the script will fail and say: "aws: command not found".
To find out the path to AWS cli simply use: `which aws`.

Of course the script has to be executable: `chmod +x backup.sh`.

#### The cronjob
Finally we can set up the cronjob.
1. `crontab -e` opens the crontab for your user.
2. If you want to run the backup every night at 12 o'clock add the follwing at the end of the crontab:
```
AWS_CONFIG_FILE=/home/jenkins/.aws/config
00 00 * * * <path-to-backup-script>/backup.sh >> <path-to-backup-log>/jenkins-backup.log 2>&1
```
Notice the first line in the crontab above the actual cron definition. Here we have to provide the path to the config file, which we created earlier. Without this line aws could not access the config file. Also adding this variable in the backup.sh did not work in my case.

I hope this helps you guys.
