Write-Host "🚀 Starting Acquisition App in Development Mode"
Write-Host "================================================"

# Check if .env.development exists
if (-Not (Test-Path ".env.development")) {
    Write-Error "❌ Error: .env.development file not found!"
    exit 1
}

# Check if Docker is running
if (-Not (docker info 2>$null)) {
    Write-Error "❌ Error: Docker is not running!"
    exit 1
}

# Create .neon_local directory if it doesn't exist
if (-Not (Test-Path ".neon_local")) {
    New-Item -ItemType Directory -Path ".neon_local" | Out-Null
}

# Add .neon_local to .gitignore if not already present
if (-Not (Select-String -Path ".gitignore" -Pattern ".neon_local/" -Quiet)) {
    Add-Content ".gitignore" ".neon_local/"
    Write-Host "✅ Added .neon_local/ to .gitignore"
}

Write-Host "📦 Building and starting development containers..."
Write-Host "   - Neon Local proxy will create an ephemeral database branch"
Write-Host "   - Application will run with hot reload enabled"
Write-Host ""

# Run migrations with Drizzle
Write-Host "📜 Applying latest schema with Drizzle..."
npm run db:migrate

# Wait for the database to be ready
Write-Host "⏳ Waiting for the database to be ready..."
docker compose exec neon-local psql -U neon -d neondb -c "SELECT 1"

# Start development environment
docker compose -f docker-compose.dev.yml up --build
