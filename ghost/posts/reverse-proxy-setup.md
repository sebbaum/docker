In this article I will explain how I hide various application servers behind an [Nginx](http://nginx.org/) reverse proxy.

But first things first, here are some important facts:

* I have a private root server, that I share with a friend.
* On this root server we run several dockerized servers which should be accessible for the public world.
* One of this servers is a [dockerized Nginx](https://hub.docker.com/_/nginx/) reverse proxy.

So far we used this proxy just to forward/map certain requests at port 80 to the upstream application servers.
Here is an example configuration:
```
server {
        listen 80;
        server_name server.sebbaum.de;

        location / {
                proxy_set_header Host $http_host;
                proxy_pass http://sebbaum.de:12345/;
        }

        access_log /var/log/nginx/sonar.sebbaum.de_access.log;
        error_log /var/log/nginx/sonar.sebbaum.de_error.log;
}
```
What this does is just forwarding all http requests to _server.sebbaum.de_ to the upstream server that is listening on port 12345. This works fine so far, but the server is also accessible via _http://sebbaum:12345_.
So this is not a true reverse proxy and not suitable for a SSL setup.

Actually I want my upstream servers to be accessible only through the proxy server. Then it is also possible to configure this proxy to terminate SSL requests. All communication behind the proxy can be http.

Here is how it works:
First I configured `eht0` to 'listen/use' at an internal IP address:
`sudo ip addr add 10.0.0.1/8 dev eth0`  
By the way this is also half the way to give a docker container a fix IP address.

Second I changed the proxy configuration:
```
server {
        listen 80;
        server_name server.sebbaum.de;

        location / {
                proxy_set_header Host $http_host;
                proxy_pass http://10.0.0.1:12345/;
        }

        access_log /var/log/nginx/sonar.sebbaum.de_access.log;
        error_log /var/log/nginx/sonar.sebbaum.de_error.log;
}
```
Finally I run the dockerized server and bind it to the internal IP address and port:
`docker run -p 10.0.0.1:12345:8080 <server-image>`

Now the upstream server can be requested using the servername defined in the proxy config, that is http://server.sebbaum.de. The request is proxied/forwarded/mapped to `10.0.0.1:12345` where the upstream server is listening and answering requests.

Of course it is required to provided some more configureation in the location section above. E.g. you want to pass the real IP address of the original client to the upstream server and configure an approriate redirect URL.

What we also gained by using this setup: Since it is possible to run servers and forward requests to `10.0.0.1:8080` as well as `10.0.0.2:8080`, my friend and I can forward requests to different internal IP addresses and do not have to look for free ports that are not used by some upstream server yet.

Feel free to leave a comment related to the approach above. I will now continue configuring my upstream servers. :D
