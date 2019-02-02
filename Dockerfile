FROM nginx:latest
RUN apt-get update && apt-get install -y openssl openssh-server && rm -rf /var/lib/apt/lists/*
COPY ./entrypoint.sh /entrypoint.sh
COPY ./conf /conf
EXPOSE 80
EXPOSE 22
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]