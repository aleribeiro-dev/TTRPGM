# Environment Setup Guide

## Prerequisites
- Node.js 18.17 or later
- Git
- npm or yarn or pnpm (commands will use pnpm in this guide)

## Initial Setup

1. Install pnpm (if not installed):
```bash
npm install -g pnpm
```

2. Initialize Next.js project with the app router:
```bash
pnpm create next-app@latest . --typescript --tailwind --eslint --app --no-src-dir --import-alias "@/*"
```
Select "Yes" for all the default options when prompted.

3. Install required dependencies:
```bash
pnpm add @radix-ui/react-icons
pnpm add class-variance-authority
pnpm add clsx
pnpm add tailwind-merge
pnpm add @hookform/resolvers
pnpm add lucide-react
pnpm add next-themes
pnpm add react-hook-form
pnpm add zod
```

4. Install development dependencies:
```bash
pnpm add -D @types/node @types/react @types/react-dom @types/eslint
pnpm add -D prettier prettier-plugin-tailwindcss
```

5. Install shadcn-ui CLI:
```bash
pnpm add -D @shadcn/ui
```

6. Initialize shadcn-ui:
```bash
pnpm dlx shadcn-ui@latest init
```
Use these configurations when prompted:
- Style: Default
- Base color: Slate
- CSS variables: Yes
- Tailwind CSS config: Yes
- Components directory: @/components
- Utils directory: @/lib/utils
- Include React Server Components: Yes

## Project Structure
Create the following directory structure:
```
app/
├── (auth)/
├── (dashboard)/
├── api/
├── layout.tsx
└── page.tsx
components/
├── ui/
└── shared/
lib/
├── utils.ts
└── constants/
types/
public/
styles/
```

## Configuration Files

Update your `tsconfig.json` to include: 