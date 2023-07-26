# ARG VERSION=latest

# FROM node:$VERSION as BUILDER

# WORKDIR /app
# COPY ./package-lock.json .
# COPY ./package.json .
# RUN npm install
# COPY ./public ./public
# COPY ./src ./src

# RUN npm run build

# FROM nginx:$VERSION
# WORKDIR /nginx
# COPY --from=BUILDER /app/build /usr/share/nginx/html
# EXPOSE 80

#It will use node:19-alpine3.16 as the parent image for building the Docker image
FROM node:latest

#It will create a working directory for Docker. The Docker image will be created in this working directory.
WORKDIR /react-docker-app

#Copy the React.js application dependencies from the package.json to the react-app working directory.
COPY package.json .

COPY package-lock.json .

#install all the React.js application dependencies
RUN npm i

# <!-- Copy the remaining React.js application folders and files from the `jenkins-kubernetes-deployment` local folder to the Docker react-app working directory -->
COPY . .

#Expose the React.js application container on port 3000
EXPOSE 3000

#The command to start the React.js application container
CMD ["npm", "start"]