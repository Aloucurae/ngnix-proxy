FROM nginx
COPY . .
ENTRYPOINT [ "./run.sh" ]
CMD ["nginx", "-g", "daemon off;"]