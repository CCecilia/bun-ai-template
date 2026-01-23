#!/bin/bash

# Setup script for Bun AI Template
echo "------------------------------------------"
echo "🤖 AI Project Initializer"
echo "------------------------------------------"

# Function to check and install Ollama
check_ollama() {
    if ! command -v ollama &> /dev/null; then
        echo "⚠️ Ollama is not installed."
        read -p "Would you like to install Ollama now? (y/n): " install_choice
        if [[ "$install_choice" == "y" ]]; then
            echo "📥 Installing Ollama..."
            # Official Ollama install script for Linux/macOS
            curl -fsSL https://ollama.com/install.sh | sh
        else
            echo "⏩ Skipping Ollama installation. Please install it manually from ollama.com."
        fi
    else
        echo "✅ Ollama is already installed ($(ollama --version))"
    fi
}

# 1. Ask for Provider
echo "Which AI provider do you want to use?"
echo "1) openai"
echo "2) gemini"
echo "3) ollama"
read -p "Select (1-3 or name): " choice

case $choice in
    1|openai)
        provider="openai"
        deps="openai"
        env_var="OPENAI_API_KEY"
        ;;
    2|gemini)
        provider="gemini"
        deps="@google/genai"
        env_var="GEMINI_API_KEY"
        ;;
    3|ollama|*)
        provider="ollama"
        deps="ollama"
        env_var=""
        check_ollama
        ;;
esac

# 2. Install dependencies
echo "📦 Installing zod, zod-to-json-schema, and $provider..."
bun add zod zod-to-json-schema $deps

# 3. Setup Environment
if [ -n "$env_var" ]; then
    read -p "🔑 Enter your $env_var: " api_key
    echo "$env_var=$api_key" > .env
    echo "✅ .env created"
fi

# 4. Copy the selected template to src/index.ts
echo "📄 Setting up src/index.ts for $provider..."
mkdir -p src
cp "templates/$provider.ts" "src/index.ts"

# 5. Cleanup (Optional: removes the templates folder from the new project)
rm -rf templates

# 6. Update README.md
echo "📝 Updating README.md..."
# Extract name from package.json using grep and sed
PROJECT_NAME=$(grep -m 1 '"name":' package.json | sed -E 's/.*"name": *"([^"]+)".*/\1/')

# Overwrite README.md with new content
cat <<EOF > README.md
# $PROJECT_NAME

This project was initialized with the **$provider** provider.

## Getting Started

1. Install dependencies: \`bun install\`
2. Run the project: \`bun run src/index.ts\`

---
Created using [bun-ai-template](https://github.com/CCecilia/bun-ai-template)
EOF

echo "------------------------------------------"
echo "🎉 Setup complete for $PROJECT_NAME!"
echo "Run 'bun run src/index.ts' to start."