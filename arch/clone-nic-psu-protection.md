# Clone NIC Tripping PSU Protection

After installing a clone Intel X520-DA1 (82599ES chipset, PCIe x8) network card, the system stopped POSTing. Pressing the power button produced a repeated clicking sound — the system would briefly attempt to power on, then immediately cut out and try again in a loop.

That clicking is the PSU's protection relay tripping. The supply is detecting an over-current or short-circuit condition and shutting down before any damage occurs.

## Why it happened

The X520-DA1 is a server-grade 10GbE card designed for enterprise environments with robust power delivery. Clone versions of these cards are common on eBay and AliExpress but often have poor power regulation circuitry that draws inconsistent or excessive current on startup — enough to trip a quality PSU's protection circuit.

In this case the card was also installed in the wrong slot: a PCIe x8 card in a PCIe x1 slot. That alone shouldn't cause a PSU to trip, but the card's power behaviour made it worse.

## Diagnosing it

The test is simple: remove any recently added expansion cards and try to POST. If the system boots cleanly without the card, the card is the problem.

## Resolution

The card was retired. The onboard Intel I225-V 2.5GbE NIC is sufficient for the actual use case (connecting to a NAS via a Unifi switch — the switch port is the bottleneck anyway, not the NIC).

## General rule

If your system suddenly won't POST and you hear a relay clicking from the PSU, don't assume the PSU is dead. A high-quality PSU with over-current protection (like a Seasonic Prime) will refuse to power on rather than deliver unstable power. Remove expansion cards one at a time until the system boots, then identify which card is causing the problem. Clone server hardware is a common culprit.
