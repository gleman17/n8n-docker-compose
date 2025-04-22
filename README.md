# N8N docker-compose setup

Yes, I know. n8n already publishes a Docker setup to run the community edition locally.

I needed to be able to have local webhooks for things like OAUTH, and the easiest way (for me) was to set up ngrok locally, then have it configure itself when the containers loaded.

This also throws in some other containers such as Python, MySQL, Mailpit, and Redis.

---

## 🚀 Installation Instructions

1. **Clone this repository:**

   ```bash
   git clone https://github.com/gleman17/n8n-docker-compose.git
   cd n8n-docker-compose
   ```

2. **Create an `.env` file (if needed):**

   You can copy and modify from a template:

   ```bash
   cp .env.example .env
   ```

3. **Start the containers:**

   ```bash
   docker-compose up -d
   ```

   This will start:
    - `n8n` (workflow automation)
    - `ngrok` (for exposing local webhooks)
    - `mysql`
    - `redis`
    - `python`
    - `mailpit` (SMTP test server)

4. **Access n8n:**

   Once running, open your browser and go to:

   ```
   http://localhost:5678
   ```

---

## 🛠 Custom Workflows

You can create a `workflows/` directory in the root of this project and store your workflow JSON files there. This directory is **not tracked by Git** and can be used for local development or backups of n8n flows.

```bash
mkdir workflows
```

Then just drop your `.json` exports into that folder.