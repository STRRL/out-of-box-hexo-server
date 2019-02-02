FROM nginx:latest
RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*
COPY ./entrypoint.sh /entrypoint.sh
EXPOSE 80
EXPOSE 22
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]