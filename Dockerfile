# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# بناء التطبيق مع التأكد من الـ base path
RUN npm run build -- --base=/

# Production stage
FROM nginx:alpine
# تنظيف الفولدر تماماً
RUN rm -rf /usr/share/nginx/html/*
# نسخ ملفات الـ dist
COPY --from=build /app/dist /usr/share/nginx/html

# إعداد Nginx للتعامل مع الـ Routing والـ Assets
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
    # التأكد من معالجة ملفات الـ assets بشكل صحيح
    location /assets/ { \
        root /usr/share/nginx/html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
