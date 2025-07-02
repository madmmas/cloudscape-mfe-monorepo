# .gitignore Summary

## 📁 **What's Ignored**

### **Dependencies & Build Artifacts**
- `node_modules/` - All dependency directories
- `dist/`, `build/` - Build output directories
- `*.log` - All log files
- `.cache/`, `.parcel-cache/` - Build caches
- `.vite/`, `.turbo/` - Tool-specific caches

### **Environment & Configuration**
- `.env*` - All environment files
- `*.local.js`, `*.local.ts`, `*.local.json` - Local overrides
- `secrets/`, `.secrets/` - Secret files

### **IDE & Editor Files**
- `.vscode/` (except extensions.json)
- `.idea/`
- `*.swp`, `*.swo` - Vim swap files
- `*~` - Backup files

### **OS Generated Files**
- `.DS_Store` (macOS)
- `Thumbs.db` (Windows)
- `*~` (Linux)

### **Testing & Coverage**
- `coverage/`
- `*.lcov`
- `.nyc_output/`
- `junit.xml`

### **Docker & Deployment**
- `docker-volumes/`
- Local Docker data

### **Micro Frontend Specific**
- `remoteEntry.js`
- `*.remote.js`

## ✅ **What's Kept**

### **Project Configuration**
- `package.json` - Package configuration
- `pnpm-lock.yaml` - Lock file (important for reproducible builds)
- `pnpm-workspace.yaml` - Workspace configuration
- `turbo.json` - Turbo configuration

### **Docker Files**
- `Dockerfile*` - Docker build files
- `docker-compose*.yml` - Docker orchestration
- `.dockerignore` - Docker ignore file

### **Source Code**
- `src/` - Source code directories
- `*.ts`, `*.tsx`, `*.js`, `*.jsx` - Source files
- `*.css`, `*.scss` - Style files

### **Documentation**
- `README.md`
- `DOCKER.md`
- `MAKEFILE_QUICK_REFERENCE.md`
- `GITIGNORE_SUMMARY.md`

### **Scripts & Tools**
- `Makefile` - Build automation
- `scripts/` - Utility scripts

### **IDE Configuration (Partial)**
- `.vscode/extensions.json` - Recommended extensions

## 🔧 **Common Scenarios**

### **New Developer Setup**
```bash
git clone <repo>
cd cloudscape-mfe-monorepo
make install
make dev
```

### **After Pulling Changes**
```bash
git pull
make install  # In case dependencies changed
make dev
```

### **Building for Production**
```bash
make build
make docker-build
make docker-prod
```

### **Cleaning Up**
```bash
make clean        # Remove build artifacts
make clean-all    # Remove everything including node_modules
make docker-clean # Clean Docker resources
```

## 🚨 **Important Notes**

1. **Keep `pnpm-lock.yaml`** - This ensures reproducible builds across environments
2. **Keep Docker files** - These are essential for containerization
3. **Keep workspace configs** - `pnpm-workspace.yaml` and `turbo.json` are needed
4. **Environment files** - `.env*` files are ignored for security
5. **Build artifacts** - `dist/` directories are ignored as they're generated

## 🔍 **Verifying .gitignore**

To check if files are being ignored correctly:

```bash
# Check git status
git status

# Check what would be ignored
git check-ignore node_modules dist .DS_Store

# See all ignored files
git status --ignored
```

## 📝 **Adding New Exclusions**

If you need to add new files to ignore:

1. Edit `.gitignore`
2. Add the pattern
3. Test with `git status`
4. Commit the changes

Example:
```bash
# Add to .gitignore
echo "my-new-file.txt" >> .gitignore

# Test
git status

# Commit
git add .gitignore
git commit -m "Update .gitignore"
``` 