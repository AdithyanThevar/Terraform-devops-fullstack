FROM node:14.17.0 as build 
WORKDIR /app
COPY . .
RUN npm install 
RUN npm run build

FROM nginx:alpine
# Set the working directory
WORKDIR /usr/share/nginx/html
# Remove the default nginx index.html
RUN rm -rf ./*
# Copy the built application from the build stage
COPY --from=build /app/build /usr/share/nginx/html/.
# Start nginx
CMD ["nginx", "-g", "daemon off;"]

