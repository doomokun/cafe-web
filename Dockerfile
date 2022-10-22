# build stage
FROM node:lts-alpine as build-stage

# Security: do not use the `root` user.
USER node

WORKDIR /app
COPY . .

ENV "VITE_API_ROOT" "http://<VITE_API_ROOT>/api"
ENV "VITE_APP_VERSION" "<VITE_APP_VERSION>"
# dev env
# EXPOSE 3000
# RUN npm install
# CMD ["npm", "run", "dev"]

# production stage
RUN npm install
RUN npm run build --production
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]