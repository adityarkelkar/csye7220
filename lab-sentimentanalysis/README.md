## Multi layered deployment with React, Spring Boot and Python on a HA k8s cluster

- Objective of this project is to deploy a sentiment analysis running web application with an Nginx server serving out ReactJS static files as frontend, Spring Boot web app handling requests from the frontend and a sentiment analysis running Python engine
- We will deploy this project to a highly available k8s cluster based off AWS
- All parts (frontend, web app, backend) have their own `Dockerfile`. You may run push this image to your personal Docker hub or AWS ECS account
- Furthermore, every part has a couple of k8s yaml files which contain the app deployment and exposed lb service
- All three parts will communicate with each other via service discovery