# 🤖 Bun AI Project Template

A high-performance, **TypeScript-first** starter template for building AI-powered applications using **Bun**. This template streamlines the setup process by providing a guided CLI to configure your preferred AI provider and automatically handles **Zod-based structured outputs**.

## ✨ Features

* **⚡ Powered by Bun**: Blazing fast runtime and package management.
* **🛠️ Multi-Provider Support**: Choose between **OpenAI**, **Google Gemini**, or **Ollama** during setup.
* **📐 Type-Safe AI**: Pre-configured with `zod` and `zod-to-json-schema` for guaranteed structured data.
* **🔌 Auto-Dependency Injection**: Only installs the SDKs you actually need.
* **📦 Environment Ready**: Automatically generates `.env` files for API keys.
* **🦙 Local AI Integration**: Detects and installs Ollama automatically for local inference.

---

## 🚀 Getting Started

To create a new project using this template, simply run:

```bash
bun create github.com/CCecilia/bun-ai-template my-ai-app
```

Or create a local version of the template

```bash
git clone git@github.com:CCecilia/bun-ai-template.git $HOME/.bun-create
```

```bash
bun create bun-ai-template my-ai-app
```
---
## Setup Steps

During the installation, the setup.sh script will guide you through:

  1. Provider Selection: Pick from OpenAI, Gemini, or Ollama.

  2. SDK Installation: Bun will install zod, zod-to-json-schema, and the chosen provider's SDK.

  3. API Configuration: If using a cloud provider, you'll be prompted to enter your API key.

  4. Boilerplate Generation: The template for your chosen provider will be moved to src/index.ts.

## 📂 Repository Structure

``` plaintext
├── src/
│   └── index.ts       # Your active AI implementation
├── templates/         # Reference implementations for each provider
│   ├── openai.ts
│   ├── gemini.ts
│   └── ollama.ts
├── .env               # Created during setup (ignored by git)
├── package.json
└── tsconfig.json
```

## 🛠️ Development

Running the App
Once the setup is complete, start your AI application with:

```bash
bun run src/index.ts
```

## 🧩 Why Structured Output?
This template focuses on Structured Outputs because modern AI applications often require data in a specific format (JSON) rather than just raw text. By using Zod, you ensure that the data returned from the LLM perfectly matches your TypeScript interfaces.