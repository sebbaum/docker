In addition to my previous post ["Running AWS commands in a cronjob"](http://www.sebbaum.de/running-aws-commands-in-a-cronjob) here is a hint how you can use ssh in a cronjob. I found this solution finally on [stackoverflow](http://stackoverflow.com/questions/4565700/specify-private-ssh-key-to-use-when-executing-shell-command-with-or-without-ruby).

My use case is the following: I want to run scheduled github pulls. Again we can configure a cronjob. But to be able to access github using our public/private key we have to create an extra config file:
1. Create a file named "config" in your .ssh folder:
`touch ~/.ssh/config`  
2. Edit this config file using your preferred editor.
```
Hostname        github.com
IdentityFile    <paht-to-your-private-key>
IdentitiesOnly  yes
```

Now the cronjob can access github by using the identity file.
