This is for test on position for Site Reliability Engineer at Niagahoster. This repository contained terraform for automation create VM, Chef for provisioning Infrastructure and repository of Swarm Example : Microservice App.

# Infrastructure Diagram
![Untitled Diagram drawio](https://user-images.githubusercontent.com/13705024/192885629-cd1a1fd1-0692-4e15-a402-747fc99ef2f1.png)

In this diagram, We will provision each server using chef to automate :
- Install Jenkins Master on VM01
- Install Docker in every servers
- Configure Docker Swarm Manager on VM01
- Configure Docker Swarm Worker on VM02 & VM03
- Install depedencies

# How Pipeline Works
![Untitled Diagram drawio (1)](https://user-images.githubusercontent.com/13705024/192885954-e9e2d127-ef37-4bfb-92f7-d25f4d327fe2.png)

- Developer push code changes to Github
- Github will trigger webhook to send build job to Jenkins
- Jenkins will build, compile and test docker image and then push image to Docker hub
- After build successfully done, it will trigger deployment job to apply rolling update to each servers.
