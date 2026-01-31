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

$status = @(scoop status 6>$null | Where-Object { $_.PSObject.Properties['Name'] })

if ($status) {
    # Toast title.
    $num_updatable_apps = $status.Count
    $title = "Scoop: $num_updatable_apps app updates"
    # Toast body.
    $body = $status.Name -join ', '
    # Invoke toast notification.
    & "$PSScriptRoot\..\toast-cli.ps1" -title $title -body $body
}

exit 0
