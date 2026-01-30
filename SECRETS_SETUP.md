# 🔐 Production Secrets Setup Guide

## Required GitHub Secrets

### For Railway Deployment:
1. `RAILWAY_TOKEN` - Your Railway API token
   - Get from: https://railway.app/account/tokens

### For Docker Hub:
2. `DOCKER_USERNAME` - Your Docker Hub username
3. `DOCKER_PASSWORD` - Your Docker Hub password/access token

### For Vercel:
4. `VERCEL_TOKEN` - Your Vercel API token (optional)
5. `database_url` - Production database URL
6. `secret_key` - Production secret key

## How to Add GitHub Secrets:

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret listed above

## Environment Variables by Platform:

### Railway:
- DATABASE_URL (auto-provided)
- SECRET_KEY (set in Railway dashboard)
- CORS_ORIGINS (set to your Railway URL)

### Vercel:
- DATABASE_URL (from Vercel Postgres or external)
- SECRET_KEY (generate new one)
- PYTHON_VERSION=3.11

### Render:
- DATABASE_URL (from Render Postgres)
- SECRET_KEY (generate new one)
- PYTHON_VERSION=3.11

## Generate Secure Keys:

```python
import secrets
print("SECRET_KEY=" + secrets.token_urlsafe(32))
print("JWT_SECRET=" + secrets.token_urlsafe(32))
```

## Security Checklist:
- ✅ Use different secrets for each environment
- ✅ Never commit .env files to git
- ✅ Rotate secrets regularly
- ✅ Use GitHub secrets for CI/CD
- ✅ Monitor for secret leaks
