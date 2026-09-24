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
- **AI RTL Assistant** — A chat panel that can answer questions about your design, detect waveform patterns to ensure compliance/non-compliance against user provided data sheets on protocols or IPs used. It opens automatically whenever a Verilog file is already open.
- **Compile Workspace** — Compile all `.v` files specified through the source YAML variable in hydra.yaml that defines the workspace through the Hydra simulator for module-lookup and syntax checking.
- **Inline Error Diagnostics** — Saving a `.v`/`.sv` file recompiles in the background and reports errors and warnings as squiggles in the editor and in the Problems panel.
- **Hierarchy Browser** - The viewer to show the Hierarchical Structure of the design with ability to control which waveforms to be shown in the waveform viewer. 
- **Per-Instance Waveforms** — Right-click any instance in the Hierarchy Browser and choose **Add to Waveform** to scope the plotted signals to just the parts of the design you care about.
- **Bus Signals** — Multi-bit signals are drawn as buses, with a Decimal / Hex / Binary radix selector in the waveform panel.
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

---

## Project Configuration (hydra.yaml)

Hydra is driven by a single `hydra.yaml` file. **Nothing runs without it** — Run Simulation,
Compile Workspace and the RTL Assistant all stop and offer to open it until it is configured.

### Where it lives

Hydra looks for it in this order:

1. `hydra.yaml` in your workspace root.
2. `hydra.yaml` in the directory of the Verilog file you are editing.
3. Neither found → Hydra **generates one** next to the Verilog file you are editing, and
   prompts you to fill it in.

The directory holding `hydra.yaml` is the project anchor: relative `sources:` paths resolve
against it, and the simulation database (`hydra.db`) is always created beside it.

### The two fields you must set

| Field | Why it is required |
|---|---|
| `sources:` | Must resolve to at least one `.v` / `.sv` file — this is your design. |
| `working_hierarchy` | The top-level instance to elaborate. It is what the Hierarchy Browser roots at and what the waveform plots. |

Leaving `working_hierarchy` empty loads nothing rather than guessing a top module, so set it
before your first run.

### `sources:` entry forms

| Entry | Meaning |
|---|---|
| `./path/to/file.v` | a single file |
| `./path/to/dir/` | all `.v`/`.sv` directly in that directory |
| `./path/to/dir/*` | the above, plus one level into sub-directories |
| `"!./path/to/file.v"` | exclude a specific file |
| `"!./path/to/dir/"` | exclude everything collected from a directory |

Only `.v` and `.sv` files are collected; all other types are ignored. Duplicate paths are
deduplicated, and exclusions are always applied after every inclusion regardless of order.
Absolute paths are accepted verbatim and may point anywhere on disk.

### Simulation settings

| Field | Default | Purpose |
|---|---|---|
| `working_hierarchy` | `""` | Top-level instance to elaborate — **required** |
| `start_time` | `0` | Simulation viewport start time |
| `time_unit` | `ns` | One of `fs`, `ps`, `ns`, `us`, `ms`, `s` |
| `max_sim_time` | `1000` | Stop time, in time units |
| `max_sim_cycles` | `5000` | Cycle-count hard stop |
| `waveform_window_size` | `-1` | Initial visible window width; `-1` = full timeline |
| `max_frozen_windows` | `5` | Frozen waveform panels kept across re-runs (oldest discarded first); `0` = none, `-1` = unlimited |

Any field that is missing or holds an invalid value falls back to its default with a warning —
it never fails the run.

### Example

```yaml
sources:
  - ./counter.v
  - ./rtl/
  - "!./rtl/scratch.v"

# Simulation configuration
start_time: 0           # simulation viewport start time
time_unit: ns           # fs | ps | ns | us | ms | s
working_hierarchy: "tb_counter"   # top-level module name (REQUIRED before simulation)
max_sim_time: 1000
max_sim_cycles: 5000
waveform_window_size: -1   # initial visible window width (time units); -1 = full timeline
max_frozen_windows: 5      # frozen waveform windows kept across restarts (oldest discarded first); 0 = none, -1 = unlimited
```

---

## Getting Started

1. Open a `.v` Verilog file in VS Code.
2. Press **Compile Workspace** (see keybindings below) or click the Hydra icon on the left primary sidebar to show up the hierarchy browser and click on "Compile workspace" button.

<p align="center">
     <img src="https://www.rrlogic.co.in/images/HydraCompile.gif" width="600" height="350" style="border:2px solid #ccc; border-radius:4px;"/><br/>
     <small><em>Compiling Workspace</em></small><br/>
</p>

3. If a hydra.yaml file is not present then compile does not proceed but a default hydra.yaml is created and prompted to be filled by the extension.
4. Fill in `sources:` and `working_hierarchy`, then compile again — see [Project Configuration](#project-configuration-hydrayaml) above for every field and the `sources:` entry forms.

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
9. Press **Open RTL Assistant** to start the AI chat panel — it also opens on its own when a Verilog file is already open.

---

## Commands & Keybindings

| Title | Linux | macOS |
|-------|---------|---------|
| Hydra: Run Simulation |`Ctrl+Shift+F9` | `cmd+Shift+s` |
| Hydra: Step Forward | `Ctrl+Shift+F10` | `cmd+shift+f` |
| Hydra: Step Backward | `Ctrl+Shift+F11`| `cmd+shift+a` |
| Hydra: Exit Replay | `Ctrl+Shift+F12`  | `cmd+shift+2` |
| Hydra: Open RTL Assistant | `Ctrl+Shift+J` | `cmd+shift+j` |
| Hydra: Compile Workspace | `Ctrl+Shift+F8` | `cmd+shift+8` |

> **Linux note:** Simulation commands use function keys to avoid conflicts with `Ctrl+Alt` / AltGr key combinations common on Linux desktop environments.

> **Windows note:** Windows does not support the extension natively at the moment, kindly invoke VSCode in WSL to use the extension

> **MacOS note:** RTL Assistant is currently not supported on macOS. stay tuned for further updates \
 _note: Apple silicon is the only hardware supported_

All commands are also available via the Command Palette (`Ctrl+Shift+P`). Simulation keybindings require editor focus (`editorTextFocus`).

You can rebind any command via **File → Preferences → Keyboard Shortcuts**.

The Hierarchy Browser adds a few more commands that have no keybinding:

| Title | Where |
|---|---|
| Set as Current Working Hierarchy | right-click an instance |
| Add to Waveform | right-click an instance |
| Remove from Waveform | right-click an instance already added |
| Search Instance | Hierarchy view title bar |
| Refresh Hierarchy | Hierarchy view title bar |
| Go to Parent Hierarchy | Hierarchy view title bar |

The three right-click actions are intentionally not in the Command Palette — they act on the
instance you clicked.

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

### Panel controls

| Control | Action |
|---|---|
| `◀` / `▶` | Step backward / forward |
| Transition jumps | Move to the previous / next value change of the selected signal |
| Edge jumps | Move to the previous / next rising or falling edge (disabled for multi-bit buses) |
| Zoom out / in | Also `Ctrl+-` and `Ctrl+=` |
| Fit | Reset the zoom to the default framing — `Ctrl+0` |
| `m` | Drop a measurement marker at the hovered time |
| `n` or `Escape` | Clear the marker |
| **Radix** | Decimal / Hex / Binary — appears when the panel has at least one multi-bit signal |
| **Start** | Live panel only: re-fetch the window from a new start offset without re-running |

Drag the canvas to pan, and `Ctrl`+scroll to zoom around the pointer. Select a signal and drop
a marker to enable the jump buttons. Below the plot, a **Signals** table lists each signal with
its value, source and triggers, and a **Queues** table lists the five event queues — clicking an
entry jumps the editor to that source line.

## Hierarchy Browser

Click the Hydra icon in the activity bar to open the **Hierarchy** view. Compile Workspace
populates it, rooted at your `working_hierarchy`.

- Each row shows the **instance name**, with its **module** dimmed beside it.
- Click a node to open its file and select the whole instantiation block.
- Right-click a node to re-root the tree (**Set as Current Working Hierarchy**) or to control
  which signals the waveform plots (**Add to Waveform** / **Remove from Waveform**).
- The title bar has search, refresh, go-to-parent and collapse-all buttons.

## RTL Assistant

User can query structural and the simulation information about the verilog. When the RTL assistant is invoked, compilation takes place according to the project configuration in the **hydra.yaml** file. 

- Opens automatically when a Verilog file is already open; `Ctrl+Shift+J` toggles it.
- Compile errors appear as clickable `file, line` links that jump straight to the problem.
- On eligible hardware (an NVIDIA GPU with 8 GB VRAM, 8 GB RAM and 20 GB free disk) the panel
  offers a one-click download of a local AI model for richer answers. Without it, the built-in
  assistant still answers structural and simulation queries.


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
                                                            