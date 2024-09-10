build() {
  docker build -t test --no-cache .
}

run() {
  docker run --name test-sql -d -it --rm test
}

exec () {
  docker exec -it test-sql bash
}

stop() {
  docker stop test-sql
}

start () {
  stop
  build
  run
  exec
}

if [ "$1" == "build" ]; then
  build
elif [ "$1" == "run" ]; then
  run
elif [ "$1" == "exec" ]; then
  exec
elif [ "$1" == "stop" ]; then
  stop
elif [ "$1" == "start" ]; then
  start
else
  echo "Usage: $0 [build|run|exec|stop]"
fi