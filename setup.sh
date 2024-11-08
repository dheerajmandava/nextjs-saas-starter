#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}==>${NC} $1"
}

print_error() {
    echo -e "${RED}==>${NC} $1"
}

# Create project structure
create_project_structure() {
    print_status "Creating project structure..."
    
    mkdir -p saas-starter/packages/{api,web}
    mkdir -p saas-starter/packages/api/src/{config,controllers,middleware,routes,services,utils}
    mkdir -p saas-starter/packages/api/prisma
    mkdir -p saas-starter/packages/web/src/{app,components,lib,hooks}
    
    print_success "Project structure created"
}

# Create README.md
create_readme() {
    print_status "Creating README.md..."
    
    cat > saas-starter/README.md << 'EOF'
# Modern SaaS Starter Template

[README content from previous response...]
EOF

    print_success "README.md created"
}

# Create environment files
create_env_files() {
    print_status "Creating environment files..."
    
    # API .env.example
    cat > saas-starter/packages/api/.env.example << 'EOF'
DATABASE_URL="postgresql://username:password@localhost:5432/saas_db"
PORT=5000
NODE_ENV=development
CLERK_SECRET_KEY=your_clerk_secret_key
CLIENT_URL=http://localhost:3000
EOF

    # Web .env.example
    cat > saas-starter/packages/web/.env.example << 'EOF'
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
CLERK_SECRET_KEY=your_clerk_secret_key
NEXT_PUBLIC_API_URL=http://localhost:5000/api
EOF

    print_success "Environment files created"
}

# Create package.json files
create_package_json() {
    print_status "Creating package.json files..."
    
    # Root package.json
    cat > saas-starter/package.json << 'EOF'
{
  "name": "saas-starter",
  "private": true,
  "scripts": {
    "dev": "turbo run dev",
    "build": "turbo run build",
    "start": "turbo run start",
    "lint": "turbo run lint"
  },
  "devDependencies": {
    "turbo": "^1.10.0"
  }
}
EOF

    # API package.json
    cat > saas-starter/packages/api/package.json << 'EOF'
{
  "name": "api",
  "version": "1.0.0",
  "scripts": {
    "dev": "nodemon src/server.js",
    "build": "node src/server.js",
    "start": "node src/server.js"
  },
  "dependencies": {
    "@clerk/clerk-sdk-node": "^4.0.0",
    "@prisma/client": "^5.0.0",
    "cors": "^2.8.5",
    "express": "^4.18.2",
    "zod": "^3.21.4"
  },
  "devDependencies": {
    "nodemon": "^2.0.22",
    "prisma": "^5.0.0"
  }
}
EOF

    # Web package.json
    cat > saas-starter/packages/web/package.json << 'EOF'
{
  "name": "web",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "@clerk/nextjs": "^4.23.2",
    "next": "13.4.19",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "tailwindcss": "^3.3.3"
  }
}
EOF

    print_success "Package.json files created"
}

# Initialize git repository
init_git() {
    print_status "Initializing git repository..."
    
    cd saas-starter
    git init
    
    # Create .gitignore
    cat > .gitignore << 'EOF'
# dependencies
node_modules
.pnp
.pnp.js

# testing
coverage

# next.js
.next/
out/
build
dist

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env
.env*.local

# turbo
.turbo

# vercel
.vercel
EOF

    git add .
    git commit -m "Initial commit: SaaS starter template"
    
    print_success "Git repository initialized"
}

# Main setup function
main() {
    print_status "Starting setup..."
    
    create_project_structure
    create_readme
    create_env_files
    create_package_json
    init_git
    
    print_success "Setup completed successfully!"
    echo -e "${GREEN}Next steps:${NC}"
    echo "1. cd saas-starter"
    echo "2. pnpm install"
    echo "3. cp packages/api/.env.example packages/api/.env"
    echo "4. cp packages/web/.env.example packages/web/.env"
    echo "5. Update environment variables"
    echo "6. pnpm dev"
}

# Run the script
main 