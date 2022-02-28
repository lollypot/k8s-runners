## How to use

### Build containers

```shell
docker build -t hammer -f hammer.dockerfile .
docker build -t slowloris -f slowloris.dockerfile .
docker build -t tor-socks-proxy -f tor-socks-proxy.dockerfile .
```

### Run tor proxy
```shell
docker run -d -p 9150:9150 tor-socks-proxy
```
or
```shell
docker run -it --rm -p 9150:9150 tor-socks-proxy
```

### Run runners with socks5 proxy arguments
```shell
docker run -it --rm hammer:latest -x --proxy-host 172.17.0.1 --proxy-port 9150 -p 443 -s example.com
```
or
```shell
./hammer.py -x --proxy-host 172.17.0.1 --proxy-port 9150 -p 443 -s example.com
```
or
```shell
docker run -it --rm slowloris:latest -x --proxy-host 172.17.0.1 --proxy-port 9150 --https -ua --port 443 example.com
```
or
```shell
./runner.py -x --proxy-host 172.17.0.1 --proxy-port 9150 --https -ua --port 443 example.com
```
