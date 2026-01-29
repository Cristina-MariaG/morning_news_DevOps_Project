FROM node:18.20

WORKDIR /app

COPY . .

RUN yarn install

EXPOSE 3000

CMD ["node", "./bin/www"]