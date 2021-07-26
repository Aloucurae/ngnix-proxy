FROM nginx
COPY ./nginx.conf .
ENTRYPOINT [ "run.sh" ]
CMD ["nginx", "-g", "daemon off;"]