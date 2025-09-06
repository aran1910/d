function PlayAudioFromUrl {
    param([string]$url)
    try {
        $tmp = "$env:TEMP\temp_$((Get-Random)).wav"
        Invoke-WebRequest $url -OutFile $tmp -UseBasicParsing
        Start-Sleep -Milliseconds 500

        if ((Get-Item $tmp).Length -gt 1000) {
            Start-Job -ScriptBlock {
                param($path)
                $p = New-Object System.Media.SoundPlayer $path
                $p.PlaySync()
                Remove-Item $path -Force
            } -ArgumentList $tmp | Out-Null

            Write-Output "✅ Playing: $url"
        } else {
            Write-Output "❌ File too small or empty."
        }
    } catch {
        Write-Output "❌ Error: $($_.Exception.Message)"
    }
}
