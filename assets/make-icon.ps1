Add-Type -AssemblyName System.Drawing

$bmp = New-Object System.Drawing.Bitmap(256, 256)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.InterpolationMode = 'HighQualityBicubic'

# Background gradient
$rect = New-Object System.Drawing.Rectangle(0, 0, 256, 256)
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, [System.Drawing.Color]::FromArgb(20, 0, 40), [System.Drawing.Color]::FromArgb(5, 5, 30), 135)
$g.FillRectangle($bgBrush, $rect)

# Rounded clip region
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$r = 40
$path.AddArc(0, 0, $r*2, $r*2, 180, 90)
$path.AddArc(256-$r*2, 0, $r*2, $r*2, 270, 90)
$path.AddArc(256-$r*2, 256-$r*2, $r*2, $r*2, 0, 90)
$path.AddArc(0, 256-$r*2, $r*2, $r*2, 90, 90)
$path.CloseFigure()
$g.SetClip($path)

$grad1 = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, [System.Drawing.Color]::FromArgb(15, 0, 35), [System.Drawing.Color]::FromArgb(8, 8, 28), 135)
$g.FillRectangle($grad1, $rect)

# Top-left: Ruby gem diamond
$pts1 = @(
    (New-Object System.Drawing.Point(75, 40)),
    (New-Object System.Drawing.Point(120, 75)),
    (New-Object System.Drawing.Point(75, 110)),
    (New-Object System.Drawing.Point(30, 75))
)
$gemBrush1 = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle(30, 40, 90, 70)),
    [System.Drawing.Color]::FromArgb(255, 100, 100),
    [System.Drawing.Color]::FromArgb(180, 20, 40), 135)
$g.FillPolygon($gemBrush1, $pts1)
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 255, 255, 255))), 55, 50, 25, 15)

# Top-right: Cyan T-piece
$blockBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(0, 229, 255))
$bs = 28
$ox = 148; $oy = 45
$g.FillRectangle($blockBrush, $ox+$bs, $oy, $bs-2, $bs-2)
$g.FillRectangle($blockBrush, $ox, $oy+$bs, $bs-2, $bs-2)
$g.FillRectangle($blockBrush, $ox+$bs, $oy+$bs, $bs-2, $bs-2)
$g.FillRectangle($blockBrush, $ox+$bs*2, $oy+$bs, $bs-2, $bs-2)
$hlBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(80, 255, 255, 255))
$g.FillRectangle($hlBrush, $ox+$bs+2, $oy+2, $bs-6, 6)
$g.FillRectangle($hlBrush, $ox+2, $oy+$bs+2, $bs-6, 6)
$g.FillRectangle($hlBrush, $ox+$bs+2, $oy+$bs+2, $bs-6, 6)
$g.FillRectangle($hlBrush, $ox+$bs*2+2, $oy+$bs+2, $bs-6, 6)

# Bottom-left: Emerald trapezoid
$pts2 = @(
    (New-Object System.Drawing.Point(45, 145)),
    (New-Object System.Drawing.Point(105, 145)),
    (New-Object System.Drawing.Point(95, 210)),
    (New-Object System.Drawing.Point(55, 210))
)
$gemBrush2 = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle(45, 145, 60, 65)),
    [System.Drawing.Color]::FromArgb(100, 255, 150),
    [System.Drawing.Color]::FromArgb(0, 180, 80), 135)
$g.FillPolygon($gemBrush2, $pts2)
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(100, 255, 255, 255))), 55, 152, 30, 12)

# Bottom-right: Gold star
$starBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 215, 0))
$cx = 195; $cy = 178; $outerR = 38; $innerR = 16; $spikes = 5
$starPts = @()
for ($i = 0; $i -lt $spikes * 2; $i++) {
    $angle = ($i * [Math]::PI / $spikes) - [Math]::PI / 2
    if ($i % 2 -eq 0) { $sr = $outerR } else { $sr = $innerR }
    $px = [int]($cx + [Math]::Cos($angle) * $sr)
    $py = [int]($cy + [Math]::Sin($angle) * $sr)
    $starPts += (New-Object System.Drawing.Point($px, $py))
}
$g.FillPolygon($starBrush, $starPts)
$g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(100, 255, 255, 255))), $cx-12, $cy-20, 18, 10)

# Glow border
$g.ResetClip()
$glowPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 0, 229, 255), 3)
$g.DrawPath($glowPen, $path)
$glowPen2 = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(30, 191, 90, 242), 6)
$g.DrawPath($glowPen2, $path)

# Save PNG
$pngPath = "C:\CortexProducts\game-portal\assets\cortex-games.png"
$bmp.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Build ICO with proper format
$icoPath = "C:\CortexProducts\game-portal\assets\cortex-games.ico"
$ms = New-Object System.IO.MemoryStream
$bw = New-Object System.IO.BinaryWriter($ms)

$sizes = @(16, 48, 256)
$pngDatas = @()

foreach ($sz in $sizes) {
    $resized = New-Object System.Drawing.Bitmap($bmp, $sz, $sz)
    $pngMs = New-Object System.IO.MemoryStream
    $resized.Save($pngMs, [System.Drawing.Imaging.ImageFormat]::Png)
    $pngDatas += ,($pngMs.ToArray())
    $resized.Dispose()
    $pngMs.Dispose()
}

# ICO header
$bw.Write([Int16]0)     # reserved
$bw.Write([Int16]1)     # type ICO
$bw.Write([Int16]3)     # 3 images

# Calculate offsets
$offset = 6 + (16 * 3) # header + 3 * 16-byte entries

# Directory entries
for ($i = 0; $i -lt 3; $i++) {
    $sz = $sizes[$i]
    if ($sz -ge 256) { $wb = [byte]0 } else { $wb = [byte]$sz }
    $bw.Write($wb)           # width
    $bw.Write($wb)           # height
    $bw.Write([byte]0)       # color palette
    $bw.Write([byte]0)       # reserved
    $bw.Write([Int16]1)      # color planes
    $bw.Write([Int16]32)     # bits per pixel
    $bw.Write([Int32]$pngDatas[$i].Length)
    $bw.Write([Int32]$offset)
    $offset += $pngDatas[$i].Length
}

# Image data
foreach ($data in $pngDatas) {
    $bw.Write($data)
}

$bw.Flush()
[System.IO.File]::WriteAllBytes($icoPath, $ms.ToArray())

$bw.Dispose()
$ms.Dispose()
$g.Dispose()
$bmp.Dispose()

Write-Host "Icon created: $icoPath"
Write-Host "PNG created: $pngPath"
