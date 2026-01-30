# Test Synova AI API
Write-Host "Testing Synova AI API..." -ForegroundColor Green

# Test 1: Root endpoint
Write-Host "`n1. Testing Root Endpoint:" -ForegroundColor Yellow
$response = Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get
Write-Host "Status: Working (HTML response)"

# Test 2: Chat endpoint
Write-Host "`n2. Testing Chat Endpoint:" -ForegroundColor Yellow
$body = @{
    query = "Hello, how are you?"
    tier = "terrestrial"
} | ConvertTo-Json

try {
    $chatResponse = Invoke-RestMethod -Uri "http://localhost:8000/api/chat" -Method Post -ContentType "application/json" -Body $body
    Write-Host "Chat Response: $chatResponse" -ForegroundColor Green
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 3: Test endpoints
Write-Host "`n3. Testing Clear Endpoint:" -ForegroundColor Yellow
try {
    $clearResponse = Invoke-RestMethod -Uri "http://localhost:8000/__test/clear" -Method Post
    Write-Host "Clear Response: $clearResponse" -ForegroundColor Green
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nAPI Testing Complete!" -ForegroundColor Green
