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

- `-Body string`: String for toast notification body
- `-Title string`: String for toast notification title (optional)
- `-Detail string`: String for toast notification detail (optional)
- `-Link string`: Link text for the toast button; must be used with `-Url`
- `-Url string`: Target URL for the toast button; must be used with `-Link`
- `-?`: Show help

## Contents

- `toast-cli.ps1`: PowerShell script to show toast notification
- `toast-cli.cmd`: Batch wrapper to `toast-cli.ps1`.
  This makes easy to invoke from command prompt.

### `tools/`

- `tools/toast-scoop-status.ps1`:
  Sample tool to show application updates installed by [scoop](https://scoop.sh)
