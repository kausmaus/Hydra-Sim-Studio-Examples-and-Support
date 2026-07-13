# Hydra Sim Studio

The Hydra Sim Studio VSCode extension can be downloaded from Marketplace within Visual Studio or from the link below
--> https://marketplace.visualstudio.com/items?itemName=RRLOGICSYSTEMSPRIVATELIMITED.Hydra-Sim-Studio



# Hydra Sim Student — FREE Verilog 2-State Simulator 

A VS Code extension for running, visualizing, replaying, Verilog 2-State simulations with an AI assistant — step-by-step, directly inside the editor. A future version will support a 4-state simulation, SystemVerilog and Gate Level simulation. 

---

## Features

- **Run Simulation** — Execute the open Verilog file through the Hydra simulator with a single shortcut.
- **Step-by-Step Replay** — Navigate forward and backward through simulation timeline frames, one event queue step at a time.
- **Color-Coded Queue Highlights** — Lines are highlighted by event queue membership (Active, Inactive, NBA, Monitor, Future) at every step.
- **Inline Signal Annotations** — Signal values and simulation time are annotated inline, next to their declaration lines.
- **Live Waveform Viewer** — A canvas-based waveform panel opens in a new window, updating automatically as you step.
- **Frozen Waveform Comparison** — Re-running the simulation freezes the previous waveform panel in place so you can compare runs side by side.
- **Legend Overlay** — A floating color legend stays pinned to the bottom of the viewport while simulation is active.
- **AI RTL Assistant** — A chat panel that can answer questions about your design, detect waveform patterns to ensure compliance/non-compliance against user provided data sheets on protocols or IPs used.
- **Compile Workspace** — Compile all `.v` files specified through the source YAML variable in hydra.yaml that defines the workspace through the Hydra simulator for module-lookup and syntax checking.
- **Hierarchy Browser** - The viewer to show the Hierarchical Structure of the design with ability to control which waveforms to be shown in the waveform viewer. 
- **Verilog 2001** - Hydra Sim supports Verilog 2001 with the **exception of the following constructs -**
     -    forever 
     -    repeat 
     -    cazex/casez 
     -    generate for
     -    generate if
     -    mixed signed arithmetic
     -    replication
     -    dumpvar
     -    dumpfile
     -    pointer arithmetic
     -    UDP and gate level modeling constructs

## Getting Started

1. Open a `.v` Verilog file in VS Code.
2. Press **Compile Workspace** (see keybindings below) or click the Hydra icon on the left primary sidebar to show up the hierarchy browser and click on "Compile workspace" button.

<p align="center">
     <img src="https://www.rrlogic.co.in/images/HydraCompile.gif" width="600" height="350" style="border:2px solid #ccc; border-radius:4px;"/><br/>
     <small><em>Compiling Workspace</em></small><br/>
</p>

3. If a hydra.yaml file is not present then compile does not proceed but a default hydra.yaml is created and prompted to be filled by the extension.
4. The "sources" and "working_hierarchy" will need to be defined. "working_hierarchy has to at least define design top or a hierarchy that will come into view in the hierarchy browser. Waveforms shown will be that of the "working_hierarchy"

<p align="center">
  <img src="https://www.rrlogic.co.in/images/HydraBrowsing.gif" width="600" height ="350" style="border:2px solid #ccc; border-radius:4px;"/><br/>
  <small><em>Hierarchy Browser</em></small><br/>
</p>

5. Press **Run Simulation** (see keybindings below) or click on play icon in the top right corner of the file window.

<p align="center">
     <img src="https://www.rrlogic.co.in/images/HydraStartSimulation.gif" width="600" height="350" style="border:2px solid #ccc; border-radius:4px;"/><br/>
     <small><em>Running Simulation</em></small><br/>
</p>

6. The waveform panel opens automatically in a new window.

<p align="center">
     <img src="https://www.rrlogic.co.in/images/HydraWaveform.gif" width="600" height="350" style="border:2px solid #ccc; border-radius:4px;"/><br/>
     <small><em>Waveform Panel</em></small><br/>
</p>

7. Use **Step Forward** / **Step Backward** to navigate the timeline.
8. Press **Exit Replay** to clear all highlights and reset state.
9. Press **Open RTL Assistant** to start the AI chat panel (will be functional in 1.1.0).

---

## Commands & Keybindings

| Title | Linux |
|-------|---------|
| Hydra: Run Simulation |`Ctrl+Shift+F9` | 
| Hydra: Step Forward | `Ctrl+Shift+F10` |
| Hydra: Step Backward | `Ctrl+Shift+F11`| 
| Hydra: Exit Replay | `Ctrl+Shift+F12` |
| Hydra: Open RTL Assistant | `Ctrl+Shift+J` | 
| Hydra: Compile Workspace | `Ctrl+Shift+F8` | 

> **Linux note:** Simulation commands use function keys to avoid conflicts with `Ctrl+Alt` / AltGr key combinations common on Linux desktop environments.

> **Windows note:** Windows does not support the extension natively at the moment, kindly invoke VSCode in WSL to use the extension


All commands are also available via the Command Palette (`Ctrl+Shift+P`). Simulation keybindings require editor focus (`editorTextFocus`).

You can rebind any command via **File → Preferences → Keyboard Shortcuts**.

---

## Editor Decorations

At each simulation step, lines in the active editor are highlighted by their event queue:

| Color | Queue | Meaning |
|-------|-------|---------|
| 🔴 Red | Active | Currently executing statements |
| 🟠 Orange | Inactive | Scheduled later in the same time step |
| 🔵 Cyan | NBA | Non-blocking assignment updates |
| 🟢 Green | Monitor | `$monitor` / `$display` callbacks |
| 🟡 Yellow | Future | Events scheduled at a future simulation time |

Additional inline annotations appear automatically:

- **Simulation time** — shown once below the module header line (`// Simulation Time = N`).
- **Signal values** — current `0`/`1` value shown next to each signal declaration (`// Value=0`).
- **When / Current markers** — each queued line annotated with its scheduled time (`// When=N`).

---

## Waveform Viewer

Running a simulation opens a **Hydra Live Waveform** panel in a separate VS Code window. The panel:

- Updates automatically as you step forward or backward.
- Is retained when hidden — navigating away and back does not require a reload.
- Is **frozen in place** (title changes to "Hydra Waveform (Frozen)") when you re-run the simulation, so you can compare the old and new runs side by side.
- Plots all accumulated signal transitions over the full simulation time axis.

## RTL Assistant

User can query structural and the simulation information about the verilog. When the RTL assistant is invoked, compilation takes place according to the project configuration in the **hydra.yaml** file. 


## Workflow Overview

```
Open .v file 
     ↓
Edit hydra.yaml with desired configuration ───────────────────────┐
     │                |                                           ↓
     |                |                  Open hierarchy browser in left pane and Compile Workspace
     |                |                                           ↓
     |                |                  navigate design hierarchy through the hierarchy browser
     |                |                                      
     |                |
     |                └───────────────────────┐
     |                                        ↓
     │                         Open RTL Assistant in the top right in the 
     │                              verilog active file window
     │                                        ↓
     │                     Query structural and simulation related information
     │                   (simulation gets triggered by the RTL assistant)
     ↓ 
Run Simulation  ──────────────────────────────────────────────────┐
     ↓                                                            │
Waveform panel opens (new window)                        Re-run freezes old panel
     ↓
First frame applied → editor decorations + inline annotations
     ↓
Step Forward / Step Backward  ←──────────────────────────────────-┐
     ↓                                                            │
Editor decorations update + waveform updates                      │
     ↓                                                            │
Exit Replay → decorations cleared, legend hidden, waveform closed─┘



```

## License

See the repository root for license information.
                                                            
