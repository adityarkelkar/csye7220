FROM node:alpine
LABEL maintainer="Aditya Kelkar <adikelkar4@gmail.com>"
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@7.3.9
COPY . /app
CMD ng serve --host 0.0.0.0 --port 4200 --disable-host-check