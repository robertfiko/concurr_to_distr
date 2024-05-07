FROM erlang:25

COPY . /app

WORKDIR /app

# start with a shell
CMD ["sh"]