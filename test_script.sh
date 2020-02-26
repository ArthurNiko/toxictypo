script log.txt
docker rm -f toxic_test_cont || true
docker rm -f python_test || true
docker build -f Dockerfile -t toxic_test .
docker run -d -p 9000:8080 --name toxic_test_cont toxic_test
docker build -f Dockerfile_python -t python_test .
docker run -d --name python_test python_test
sleep 10
exit