# NVMe Overheating

The WD Black SN850X 4TB is a fast drive that runs extremely hot. Under combined load (game install + video streaming + network file copy), my system was spontaneously hard-resetting with no kernel panic and nothing useful in the logs — just a clean cut-off, which is the signature of thermal protection or a power event rather than a software crash.

The drive was sitting at **55–56°C at near-idle**. The correct idle range with a working heatsink is around 40°C.

## Diagnosing NVMe temperature

```bash
watch -n 1 'cat /sys/class/nvme/nvme0/hwmon*/temp*_input | awk "{print \$1/1000\"°C\"}"'
```

This polls the hwmon interface every second. `temp1_input` is the composite (overall) temperature; additional entries are sensor-specific readings.

The SN850X warning threshold is 70°C and critical is 85°C — but in practice, my system was crashing well below those, suggesting the drive has its own lower-level protection or the combination of NVMe heat and other thermals was enough to trigger a hard reset.

## The fix

The heatsink wasn't making proper contact. Re-seating it with a fresh thermal pad brought idle temps back down to the low 40s and the crashes stopped.

If you're on a Z490 board with a 10th-gen (Comet Lake) CPU, note that **all three M.2 slots are PCH-connected**, not CPU-direct. None of them get PCIe 4.0 — they're all PCIe 3.0 x4 through the chipset. This doesn't affect thermals, but it's worth knowing if you were expecting CPU-direct bandwidth.

## What a healthy temperature looks like

| State | Temp |
|---|---|
| Idle (heatsink working) | ~40°C |
| Heavy sequential I/O | 55–65°C |
| Danger zone | 70°C+ |

If you're seeing 55°C+ at idle, check the heatsink before assuming a driver or OS issue.
