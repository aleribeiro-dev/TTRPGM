# Create main directories
mkdir -p "app/(auth)"
mkdir -p "app/(dashboard)"
mkdir -p app/api
mkdir -p components/ui
mkdir -p components/shared
mkdir -p lib/constants
mkdir -p types
mkdir -p styles

# Create initial placeholder files to ensure Git tracks empty directories
touch "app/(auth)/.gitkeep"
touch "app/(dashboard)/.gitkeep"
touch app/api/.gitkeep
touch components/ui/.gitkeep
touch components/shared/.gitkeep
touch lib/constants/.gitkeep
touch types/.gitkeep
touch styles/.gitkeep 