function PlayAudioFromUrl {
    param([string]$url)

    try {
        $tmp = "$env:TEMP\temp_$((Get-Random)).wav"
        Invoke-WebRequest $url -OutFile $tmp -UseBasicParsing
        Start-Sleep -Milliseconds 500

        if ((Get-Item $tmp).Length -gt 1000) {
            $player = New-Object System.Media.SoundPlayer $tmp
            $player.Play()
            Start-Sleep -Milliseconds 500
            Write-Output "✅ Playing: $url"
            Start-Sleep -Seconds 5
            Remove-Item $tmp -Force
        } else {
            Write-Output "❌ File too small or empty."
        }
    } catch {
        Write-Output "❌ Error: $($_.Exception.Message)"
    }
}
