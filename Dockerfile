FROM node:20-alpine
RUN addgroup app && adduser -S -G app app
USER root
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
ENV API_URL=http://api.myapp.com/
EXPOSE 3000
CMD ["npm", "run", "dev"]
