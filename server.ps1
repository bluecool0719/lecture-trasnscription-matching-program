# 강의록 자동 생성기 서버
$port = 7432
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$htmlPath = Join-Path $scriptDir "index.html"
$libsDir = Join-Path $scriptDir "libs"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()

Write-Host "강의록 자동 생성기 실행 중!" -ForegroundColor Cyan
Write-Host "주소: http://localhost:$port" -ForegroundColor Green
Write-Host "이 창을 닫으면 종료됩니다" -ForegroundColor Yellow

Start-Sleep -Milliseconds 400
Start-Process "http://localhost:$port"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $req = $context.Request
    $res = $context.Response

    $res.Headers.Add("Access-Control-Allow-Origin", "*")
    $res.Headers.Add("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
    $res.Headers.Add("Access-Control-Allow-Headers", "Content-Type, X-Api-Key")

    if ($req.HttpMethod -eq "OPTIONS") {
        $res.StatusCode = 200
        $res.Close()
        continue
    }

    if ($req.HttpMethod -eq "GET") {
        $path = $req.Url.AbsolutePath

        # /libs/ 경로 처리
        if ($path.StartsWith("/libs/")) {
            $fname = $path.Substring(6)
            $fpath = Join-Path $libsDir $fname
            if (Test-Path $fpath) {
                $bytes = [System.IO.File]::ReadAllBytes($fpath)
                $res.ContentType = "application/javascript"
                $res.ContentLength64 = $bytes.Length
                $res.OutputStream.Write($bytes, 0, $bytes.Length)
                $res.Close()
                continue
            }
        }

        # index.html
        $bytes = [System.IO.File]::ReadAllBytes($htmlPath)
        $res.ContentType = "text/html; charset=utf-8"
        $res.ContentLength64 = $bytes.Length
        $res.OutputStream.Write($bytes, 0, $bytes.Length)
        $res.Close()
        continue
    }

    if ($req.HttpMethod -eq "POST") {
        try {
            $apiKey = $req.Headers["X-Api-Key"]
            $reader = New-Object System.IO.StreamReader($req.InputStream)
            $body = $reader.ReadToEnd()
            $reader.Close()

            $wr = [System.Net.WebRequest]::Create("https://api.anthropic.com/v1/messages")
            $wr.Method = "POST"
            $wr.ContentType = "application/json"
            $wr.Headers.Add("x-api-key", $apiKey)
            $wr.Headers.Add("anthropic-version", "2023-06-01")
            $wr.Timeout = 120000

            $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
            $wr.ContentLength = $bodyBytes.Length
            $s = $wr.GetRequestStream()
            $s.Write($bodyBytes, 0, $bodyBytes.Length)
            $s.Close()

            try {
                $webRes = $wr.GetResponse()
                $sr = New-Object System.IO.StreamReader($webRes.GetResponseStream())
                $out = $sr.ReadToEnd()
                $sr.Close()
                $webRes.Close()
                $outBytes = [System.Text.Encoding]::UTF8.GetBytes($out)
                $res.ContentType = "application/json"
                $res.StatusCode = 200
                $res.ContentLength64 = $outBytes.Length
                $res.OutputStream.Write($outBytes, 0, $outBytes.Length)
            } catch [System.Net.WebException] {
                $sr2 = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
                $errOut = $sr2.ReadToEnd()
                $sr2.Close()
                $errBytes = [System.Text.Encoding]::UTF8.GetBytes($errOut)
                $res.ContentType = "application/json"
                $res.StatusCode = 400
                $res.ContentLength64 = $errBytes.Length
                $res.OutputStream.Write($errBytes, 0, $errBytes.Length)
            }
        } catch {
            $errMsg = 'server error'
            $errJson = '{"error":"' + $errMsg + '"}'
            $errBytes = [System.Text.Encoding]::UTF8.GetBytes($errJson)
            $res.ContentType = "application/json"
            $res.StatusCode = 500
            $res.ContentLength64 = $errBytes.Length
            $res.OutputStream.Write($errBytes, 0, $errBytes.Length)
        }
        $res.Close()
        continue
    }

    $res.StatusCode = 404
    $res.Close()
}
