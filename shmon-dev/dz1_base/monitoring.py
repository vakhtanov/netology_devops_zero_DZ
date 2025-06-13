#!/usr/bin/env python3
import time
import json
import os
from datetime import datetime

LOG_DIR = "/home/user/sys_mon_python/log"

def read_cpu_stats():
    with open("/proc/stat", "r") as f:
        line = f.readline()
    parts = line.strip().split()
    keys = ["user", "nice", "system", "idle"]
    values = list(map(int, parts[1:1+len(keys)]))
    return dict(zip(keys, values))

def read_mem_info():
    meminfo = {}
    needed_keys = ["MemTotal", "MemFree"]
    with open("/proc/meminfo", "r") as f:
        for line in f:
            parts = line.split()
            key = parts[0].rstrip(":")
            if key in needed_keys:
                meminfo[key] = int(parts[1])
            if len(meminfo) == len(needed_keys):
                break
    return meminfo

def read_loadavg():
    with open("/proc/loadavg", "r") as f:
        parts = f.read().split()
    # Возьмём 1-минутное среднее значение нагрузки
    load1 = float(parts[0])
    return {"load1": load1}

def collect_metrics():
    timestamp = int(time.time())
    cpu_stats = read_cpu_stats()
    mem_info = read_mem_info()
    load_avg = read_loadavg()

    metrics = {
        "timestamp": timestamp,
        **cpu_stats,
        **mem_info,
        **load_avg,
    }
    return metrics

def write_log(metrics):
    dt = datetime.fromtimestamp(metrics["timestamp"])
    filename = dt.strftime("%y-%m-%d-awesome-monitoring.log")
    filepath = os.path.join(LOG_DIR, filename)

    json_line = json.dumps(metrics, ensure_ascii=False)

    with open(filepath, "a") as f:
        f.write(json_line + "\n")

def main():
    metrics = collect_metrics()
    write_log(metrics)

if __name__ == "__main__":
    main()
