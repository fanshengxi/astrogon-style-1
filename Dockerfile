FROM mcr.microsoft.com/devcontainers/javascript-node:22-bookworm

WORKDIR /app

COPY package*.json ./

ENV npm_config_registry=https://registry.npmmirror.com \
    npm_config_sharp_binary_host=https://npmmirror.com/mirrors/sharp \
    npm_config_sharp_libvips_binary_host=https://npmmirror.com/mirrors/sharp-libvips \
    npm_config_fetch_retries=5 \
    npm_config_fetch_retry_maxtimeout=120000

RUN npm ci

COPY . .

EXPOSE 4321

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
