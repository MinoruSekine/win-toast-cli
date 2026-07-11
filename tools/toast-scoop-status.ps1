# SPDX-License-Identifier: AGPL-3.0-or-later
#
# toast-scoop-status.ps1 - Notify `scoop status` results (e.g. app updates)
# Copyright (C) 2026  Minoru Sekine
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

$oldPriority = [System.Diagnostics.Process]::GetCurrentProcess().PriorityClass

try {
    [System.Diagnostics.Process]::GetCurrentProcess().PriorityClass = 'Idle'

    scoop update

    if ($LASTEXITCODE -eq 0) {
        $update_status_message = ""
    } else {
        $update_status_message = "Warning: `scoop update` is failed."
    }

    $status = @(scoop status 6>$null | Where-Object { $_.PSObject.Properties['Name'] })

    # Compose link URL.
    $thisPwshFullPath = `
      Join-Path $PSHOME "$((Get-Process -Id $PID).ProcessName).exe"
    $thisPwshFullPath = $thisPwshFullPath.Replace('\', '/')
    $encodedPwshFullPath = [URI]::EscapeDataString($thisPwshFullPath)

    $toastParam = @{
        Link = "Open PowerShell console"
        Url  = "file:///$encodedPwshFullPath"
    }

    if ($status) {
        $num_updatable_apps = $status.Count
        $toastParam["Title"]  = "Scoop: $num_updatable_apps app updates"
        $toastParam["Body"]   = $status.Name -join ', '
        $toastParam["Detail"] = $update_status_message
    } else {
        $toastParam["Title"]  = "Scoop: No updates available"
        $toastParam["Body"]   = $update_status_message
    }

    # Show toast notification if app updates available or `scoop update` failed.
    if ($status -or $update_status_message) {
        & "$PSScriptRoot\..\toast-cli.ps1" @toastParam
    }
}
finally {
    [System.Diagnostics.Process]::GetCurrentProcess().PriorityClass = $oldPriority
}

exit 0
