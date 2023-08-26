rewwatch from video 1-7

sidenote
api:
build: ./
container_name: react_container
ports: - '3000:3000'
environment:
API_URL: http://api.myapp.com/

install docker for your machine
visit the link - https://docs.docker.com/desktop/install/windows-install/

if you experience the wsl2 issue visit -https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package
to update your wsl version on your system or run - wsl.exe --update on your terminal to update your wsl

install the update for wsl
run - $ docker version
this to check if your docker engine is running
also you server must be running else we go through the process again

whats a dockerfile, how does docker implement it changes

when we take an application we dockerate it

dockerfile is a plain text file that inlcudes information that docker uses to package up information into an image

-image contians everything our application needs to run

1.  the cut-down os
    2.a runtime environment
2.  application file
3.  application variable

docker container are built based on the docekrfile image
conatianer is just a process- the apllication is ran insdie the contianer

$ docker run ...

docker hub
after creatimg the docker image we send it to a registry cslled the docker hub just like github stores codes
then from the docker hub we can send it to any production machine

starting out
create a directory $mkdir hello-docker
create a file App.js

insert picture

in order to run this program on another machine we reuire to the following instruction
-start with an OS
-install Node
-copy app files
-run node app.js

for a bigger program we would have lot sof stuff to run so docker comes in

to run our small app with docker

1. create the docker file
   Dockerfile - ensure the D is capital and everyother snamll letters, it has no file extenison
2. install the docker extension if you have none on you

3. we build the the base image on the docker andd add other images to it
   more like iherentance

FROM Baseimage:tag(which linux dirtibution we want to use)alphine(image)
COPY we need to copy the files in the directory to the app directory into the iamge
WORKDIR to direct to the working directory
CMD Command instruction to excute the command

next we run the docker build
in your terminal type
$ docker build -t (name )hello-docker .(where docker can find the docker file).

Linux

Building docker images

it contains all the information needed to start a contianer that best suit the apllication to be ran

contianer
-provides and isolated environs
-can be stopped & restarted
-its just a porcess

starting...

we need a docker file which contians the information for building an image

FROM -spcifitying the base image - like what operating sysytem
WORKDIR - working directory
COPY
ADD
RUN- ecutring woriking command
ENV -sending environment variable
EXPOSE -which port its running on
USER -
CMD-
ENTRYPOINT-

on the project create a docker file
FROM node:14.21.3-alpine3.17(using tags on dockerhub browers for a suitable verion and copy the number)
microsoft uses a link from docker smaples because the dont host on docker

$ docker build -t(tag the image) react-app(image name) .(where to fing the dockerfile)

to view all the iamges we use
$docker image -ls:

to start the contianer

$docker run -it react-app(contianer name)

but we want it with bash or shell because alpine does come with bash

$docker run -it react-app sh

the above creates an environment for the application to run on

copying the applcation files and directory into the base image

we can use ADD or COPY
ADD- aditonal feature
COPY- we cpoy from the only current directory the image is in
COPY package\*.json
to copy everthing COPY . /app/
ADD - can uncomprise a file also it lets us use a link
but only use when you need such function

run docker again

to ignore some files
.dockerignore

RUN command
RUN npm install
then you build again

setting up Environment variables
ENV
run and $ printenv - to see all environment variables

creating user
RUN addgroup app && adduser -S -G app app

whilst creating a user you want to ensure not to expose your root user and keep the user in the other so as to have control of your apps and permission

defining entrypoints

using alphine to create groups and user
$docker run -it alpine
alphine installs automatically if dint have one
to create a group # addgroup name

# adduser -S -G app(group name) app(userName)

to run the app as a human being
$docker run contianer npm run dev

CMD - this runs a default command  
 its not good to have multiple command as docker will only run the last one

difference between the RUN and the CMD command is that RUN is ran during the build time of the image - when building the image , while the CMD is a run time image - excuted when starting the conatiner

two types of CMD commands
the shell form - it runs on the the shell /bin/sh
CMD npm start
it has to spring another shell to work
secondly, the EXEC form
CMD ["npm", "start"]
it doesn't spin up a new shell

ENTRYPOINT-
this is used when you know the command should not be easily changed because its a neccesity

Speeding up build processes

we do this by building layers

we can first check the history by using
$ docker history image-name

OPTIMIZATION (optimizing your docker contianer)

1. docker reads file from the top and you can see it form looking at the history
   $docker history image-name

and would have to rebuild if a change is made to the file, this can cause ling runtime to rebuild both all the packages from scratch, so we want to run the npm install based on a change on the package.json file alone

basically
the instructions that change frequently should be at the bottom while the instructions that dont change frequently should be at the top

to c;ear dangling images that has swayed from our images we prune the image

$docker image prune
$

$docker ps - is actually to check contianers
to prune (not in use contianer)  containers we use 
$ docker container prune

to remove
$ docker image rm name/Id

Tags

$ docker build -t react-app:1 .
for an already made images we use

$ docker image tag react-app:currentTag react-app:newName

to push to dockerhub
$docker tag local-image:tagname new-repo:tagname
you are basically tagging the local image with the image you want to push to dockerhub

$docker push new-repo:tagname
$ docker push iamkalio/react-app:tagname

saving and loading images

$docker image save -o imageName.tar(like saving as a zipped file) imgeName:tag

Loading an image to the conatiner using a .tar file

$ docker image load -i react-app.tar

to connect the container to the
