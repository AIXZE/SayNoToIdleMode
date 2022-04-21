$host.ui.RawUI.WindowTitle = “Say-No-To-Idle-Mode”

Add-Type -AssemblyName System.Windows.Forms
Add-Type -Name ConsoleUtils -Namespace WPIA -MemberDefinition @'
   [DllImport("Kernel32.dll")]
   public static extern IntPtr GetConsoleWindow();
   [DllImport("user32.dll")]
   public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'@

$window = [WPIA.ConsoleUtils]::GetConsoleWindow()
[WPIA.ConsoleUtils]::ShowWindow($window, 0)

$shell = New-Object -com "Wscript.Shell"

while ($true) {
    $pos1 = [System.Windows.Forms.Cursor]::Position

    Start-Sleep -Seconds 10

    $pos2 = [System.Windows.Forms.Cursor]::Position

    if ($pos1.X -eq $pos2.X -and $pos1.Y -eq $pos2.Y) {
        $shell.sendkeys("{SCROLLLOCK}")

        Start-Sleep -Milliseconds 10

        $shell.sendkeys("{SCROLLLOCK}")
    }

    Start-Sleep -Seconds 60
}
