FROM node:12-alpine3.14 AS builder
LABEL stage=builder
RUN apk update && apk add --no-cache git
WORKDIR /
RUN git clone https://github.com/Ola-Alkhateeb/crimsonQ-dashboard.git

WORKDIR /crimsonQ-dashboard
RUN echo 'VUE_APP_API_URL="http://localhost:8080/api/"' >> .env
RUN echo  'VUE_APP_LOGIN_URL="http://localhost:8080/login/"' >> .env 

RUN npm install
RUN npm run build 

FROM nginx
COPY --from=builder /crimsonQ-dashboard/dist/ /usr/share/nginx/html

EXPOSE 80