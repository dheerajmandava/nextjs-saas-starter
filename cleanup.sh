#!/bin/bash

# Clean up any existing temp directory
rm -rf temp_clean

# Create temporary directory for cleaned files
mkdir -p temp_clean

# Create new directory structure
mkdir -p temp_clean/packages/api/src/{controllers,middleware,routes,services,utils,config}
mkdir -p temp_clean/packages/api/prisma
mkdir -p temp_clean/packages/web/src/{app,components,lib,hooks}

# Copy and clean API files
cp packages/api/src/config/corsConfig.js temp_clean/packages/api/src/config/
cp packages/api/src/middleware/{auth.js,validation.js} temp_clean/packages/api/src/middleware/
cp packages/api/src/utils/{errors.js,response.js} temp_clean/packages/api/src/utils/
cp packages/api/src/services/shop.service.js temp_clean/packages/api/src/services/
cp packages/api/prisma/schema.prisma temp_clean/packages/api/prisma/
cp packages/api/package.json temp_clean/packages/api/

# Copy and clean Web files
cp -r packages/web/src/components temp_clean/packages/web/src/
cp packages/web/src/lib/api.js temp_clean/packages/web/src/lib/
cp packages/web/src/middleware.js temp_clean/packages/web/src/
cp packages/web/package.json temp_clean/packages/web/

# Copy root files
cp package.json temp_clean/

# Create new README.md
cat > temp_clean/README.md << 'EOF'
# SaaS Starter Template

A modern SaaS starter template with:
- 🚀 Next.js frontend with shadcn/ui
- 💻 Express.js backend
- 🔐 Authentication with Clerk
- 🎨 Styled with Tailwind CSS
- 🗃️ Database with Prisma
- 🌙 Dark mode support
- 📱 Responsive design

## Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/saas-starter.git
    cd saas-starter
    ```

2. Install dependencies:
    ```bash
    pnpm install
    ```

3. Set up environment variables:
    ```bash
    cp packages/api/.env.example packages/api/.env
    cp packages/web/.env.example packages/web/.env
    ```

4. Start development servers:
    ```bash
    pnpm dev
    ```

## Features
- User authentication and authorization
- Shop/tenant management
- Role-based access control
- API rate limiting
- Error handling
- Form validation
- Dark mode
- Responsive UI components

## Tech Stack
- Next.js 14
- Express.js
- Prisma
- PostgreSQL
- Clerk Authentication
- Tailwind CSS
- shadcn/ui
- Zod validation
EOF

# Create example environment files
cat > temp_clean/packages/api/.env.example << 'EOF'
DATABASE_URL="postgresql://user:password@localhost:5432/saas_db"
PORT=5000
CLERK_SECRET_KEY=your_clerk_secret_key
CLIENT_URL=http://localhost:3000
EOF

cat > temp_clean/packages/web/.env.example << 'EOF'
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
NEXT_PUBLIC_API_URL=http://localhost:5000/api
CLERK_SECRET_KEY=your_clerk_secret_key
EOF

# Initialize git repository
cd temp_clean
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

# Create initial commit
git add .
git commit -m "Initial commit: SaaS starter template"

echo "Project cleaned and prepared for GitHub!"