# SpicetifyAP

A PowerShell script that monitors Spotify for updates and automatically runs `spicetify backup apply` after an update is detected. This ensures your custom Spicetify themes and extensions are reapplied seamlessly without manual intervention.

---

## Features

- **Automated Update Detection**: 
  Monitors Spotify's installation folder for signs of updates, such as:
  - Changes in the `Update` folder.
  - Modifications to key files like `Spotify.exe`.

- **Auto-Apply Spicetify**: 
  Automatically runs `spicetify backup apply` to restore your customizations after Spotify updates.

- **Runs in the Background**: 
  Set it up to start with your system and run silently in the background.

---

## Prerequisites

- **Spicetify CLI**: Install Spicetify by following the instructions [here](https://spicetify.app/docs/getting-started).
- **PowerShell**: Ensure you have PowerShell installed (comes pre-installed on most Windows systems).
- **Script Execution Policy**: Enable script execution by running:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/axeltechtips/spicetifyap.git
   ```

2. **Set Up the Script**:
   - Copy the `SpicetifyUpdater.ps1` file to a location of your choice.
   - Update the script's Spotify installation path if necessary (default: `$env:LOCALAPPDATA\Spotify`).

3. **Create a Startup Task** (Optional):
   - Save the provided `RunSpicetifyUpdater.bat` file to a location of your choice.
   - Place the batch file in your Windows startup folder:
     1. Press `Win + R`, type `shell:startup`, and press Enter.
     2. Copy the `.bat` file into this folder.

---

## Usage

Run the script manually or automatically on system startup. The script will:

1. Monitor Spotify's `Update` folder and key files for changes.
2. Automatically apply your Spicetify customizations if an update is detected.

To stop the script, close the PowerShell window running it.

---

## How It Works

1. **Detection**:
   - Monitors Spotify's `Update` folder for new or modified files.
   - Checks for changes to `Spotify.exe`'s `LastWriteTime` property.

2. **Action**:
   - When an update is detected, it runs:
     ```powershell
     spicetify backup apply
     ```

3. **Continuous Monitoring**:
   - The script runs in an infinite loop with delays to minimize resource usage.

---

## Customization

You can modify the following in `SpicetifyUpdater.ps1`:

- **Monitoring Intervals**: Adjust the `Start-Sleep` delays for more or less frequent checks.
- **Paths**: Update the Spotify installation path if it differs from the default.

---

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to fork this repository and submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
