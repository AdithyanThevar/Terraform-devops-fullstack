FROM node:14.17.0 as build 
WORKDIR /app
COPY . .
RUN npm install 
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build /usr/share/nginx/html/.
CMD ["nginx", "-g", "daemon off;"]

