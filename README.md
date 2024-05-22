## Usage

Build container with dependencies

```bash
docker compose build dependencies-cpu
```

Now you have few options. First you can get into container via terminal

Start container

```bash
docker compose up -d dependencies-cpu
```

Get into started container

```bash
docker compose exec -it dependencies-cpu bash
```

And second option is to use visual studio extension that allows 
you to get into running container. This option will actually be better 
in the way that now visual studio code could see your installed dependencies
and show suggestions which is convinient

## Metrics

To get information about all availible metrics you can run

```bash
nvprof --query-metrics
```

Profile kernel with all metrics

```bash
nvprof --metrics all ./.kernel.cu 
```

Profile kernel with custom metrics

```bash
nvprof --metrics dram_read_throughput --metrics dram_write_throughput --metrics dram_read_transactions --metrics flop_count_dp --kernels add ./.kernel.cu
```
