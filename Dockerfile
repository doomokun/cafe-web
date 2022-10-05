# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY . .

# dev env
# EXPOSE 3000
# RUN npm install
# CMD ["npm", "run", "dev"]

# production stage
RUN npm install
RUN npm run build --production
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]