# AIO Pump Running Slow Due to BIOS Fan Header

An AIO pump plugged into a fan header that has a temperature-controlled fan curve will run slower than it should — sometimes much slower. My Tryx Panorama 240 pump was running at around **950 RPM** when it should be at full speed constantly.

The symptom wasn't an obviously dead cooler. The CPU was being cooled, just not as well as it should be. Under all-core load I was hitting 93°C with throttling starting, which on an i9-10900K in a reasonably ventilated case is a sign the pump isn't moving enough coolant.

## The fix

On a **Gigabyte Z490 Aorus Master**, the AIO pump is plugged into `SYS_FAN6_PUMP`. In the BIOS:

**Smart Fan 5 → SYS_FAN6_PUMP → Full Speed (100% fixed duty)**

The BIOS was treating the pump header like a case fan and applying a curve based on CPU temperature. Setting it to full speed fixed the pump RPM immediately.

## General rule

AIO pumps should always run at 100% — they're not loud, and the coolant flow rate affects thermal performance far more than the small amount of power saved by running the pump slower. If your AIO radiator fans are also controlled by this header, separate the pump and fan controls so the fans can still respond to temperature while the pump runs flat-out.

If your board has a dedicated pump header (often labelled `W_PUMP+` or `AIO_PUMP`), use that instead — it typically defaults to full speed and doesn't need manual configuration.
