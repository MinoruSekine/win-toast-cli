# win-toast-cli

Invoke toast notification by command-line.

## How to install

### [Scoop](https://scoop.sh)

`win-toast-cli` is available in non-"known bucket"
[MinoruSekine/scoop-bucket-MinoruSekine](https://github.com/MinoruSekine/scoop-bucket-MinoruSekine).

```powershell
> scoop bucket add MinoruSekine https://github.com/MinoruSekine/scoop-bucket-MinoruSekine
> scoop install MinoruSekine/win-toast-cli
```

## Usage

On PowerShell console,

```powershell
> toast-cli.ps1 -body "Body message"
```

### Options

- `-body string`: String for toast notification body
- `-title string`: String for toast notification title (optional)
- `-detail string`: String for toast notification detail (optional)
- `-?`: Show help

## Contents

- `toast-cli.ps1`: PowerShell script to show toast notification
- `toast-cli.cmd`: Batch wrapper to `toast-cli.ps1`.
  This makes easy to invoke from command prompt.

### `tools/`

- `tools/toast-scoop-status.ps1`:
  Sample tool to show application updates installed by [scoop](https://scoop.sh)
