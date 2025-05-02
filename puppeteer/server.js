const express = require('express');
const puppeteer = require('puppeteer-extra');
const StealthPlugin = require('puppeteer-extra-plugin-stealth');
const bodyParser = require('body-parser');

// Add stealth plugin to puppeteer
puppeteer.use(StealthPlugin());

const app = express();
app.use(bodyParser.json());

app.post('/scrape', async (req, res) => {
    const { url, fullPage = false } = req.body;

    if (!url) {
        return res.status(400).json({ error: 'Missing url in request body' });
    }

    console.log(`Navigating to: ${url}`);

    let browser;
    try {
        browser = await puppeteer.launch({
            headless: "new", // modern headless mode
            args: ['--no-sandbox', '--disable-setuid-sandbox'],
        });

        const page = await browser.newPage();

        await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36');

        await page.goto(url, { waitUntil: 'networkidle2' });

        const content = await page.content(); // Get the full HTML content

        res.json({ success: true, content });

    } catch (error) {
        console.error('Scrape failed:', error);
        res.status(500).json({ success: false, error: error.toString() });
    } finally {
        if (browser) {
            await browser.close();
        }
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Puppeteer server listening on port ${PORT}`);
});
