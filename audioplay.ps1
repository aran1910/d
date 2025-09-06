function PlayAudioFromUrl {
    param([string]$url)
    try {
        $tmp = "$env:TEMP\temp.wav"
        Invoke-WebRequest $url -OutFile $tmp -UseBasicParsing
        Start-Sleep -Milliseconds 500
        if ((Get-Item $tmp).Length -gt 1000) {
            Write-Output "✅ Playing: $url"
            $p = New-Object System.Media.SoundPlayer $tmp
            $p.PlaySync()
            Remove-Item $tmp -Force
        } else {
            Write-Output "❌ Invalid or empty audio file."
        }
    } catch {
        Write-Output "❌ Error: $($_.Exception.Message)"
    }
}
