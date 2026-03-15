FROM ubuntu:22.04 AS build


RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs build-essential && \
    apt-get clean

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM ubuntu:22.04


RUN apt-get update && apt-get install -y nginx && apt-get clean

RUN rm -rf /var/www/html/*

COPY --from=build /app/build /var/www/html


EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]