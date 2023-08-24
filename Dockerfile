FROM node:20-alpine
RUN addgroup app && adduser -S -G app app
USER root
WORKDIR /app
COPY . .
RUN npm install
ENV API_URL=http://api.myapp.com/
EXPOSE 3000