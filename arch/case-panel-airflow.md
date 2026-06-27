# Case Panel Blocking AIO Radiator Exhaust

During a burn-in stress test, I was seeing CPU peaks of 93°C with the i9-10900K throttling down from 4800 MHz to 4600 MHz near the end of the run. The AIO pump had already been fixed (see [AIO Pump Running Slow](aio-pump-fan-header.md)), so it wasn't a coolant flow issue.

Removing the case top panel dropped the CPU peak by **~10°C** — down to 83°C — and eliminated throttling entirely. The radiator was mounted as a top exhaust, and the panel was close enough to the fans that it was significantly restricting airflow out of the case.

## Why this happens

Mesh top panels with a reasonable gap usually don't cause this. But solid or near-solid panels, panels with small ventilation holes, or panel designs that sit very close to the radiator fans can create enough back-pressure to reduce fan airflow substantially. The fans spin at the same speed but move less air.

## What to do

If your AIO is mounted as a top exhaust and you're seeing higher-than-expected CPU temps:

1. Remove the top panel entirely and re-run your workload or benchmark
2. If temps drop noticeably, the panel is the bottleneck
3. Options: keep the panel off, replace it with a mesh panel, or tune the radiator fan curves to compensate (pushing them harder to overcome the restriction)

The case in question has a glass/solid top panel with limited ventilation — a common trade-off between aesthetics and airflow. For an AIO top exhaust, that trade-off bites harder than it would for case fans alone.
