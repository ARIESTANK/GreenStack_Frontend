FROM node:20-bullseye

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

RUN npm install -g serve

EXPOSE 3000
ENV PORT $PORT

CMD ["serve", "-s", "build", "-l", "3000"]