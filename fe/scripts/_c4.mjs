import { spawn } from "node:child_process";
import path from "node:path";
import puppeteer from "puppeteer-core";

const ROOT = process.cwd();
const preview = spawn(process.execPath, [path.join(ROOT, "node_modules", "vite", "bin", "vite.js"), "preview", "--port", "4188", "--strictPort"], { cwd: ROOT, stdio: "ignore" });
await new Promise((r) => setTimeout(r, 2500));
const browser = await puppeteer.launch({
  executablePath: "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
  headless: "new",
  args: ["--no-sandbox"],
});
const page = await browser.newPage();
const slug = process.argv[2] || "dinas-bina-marga-dan-sumber-daya-air-dbmsda-kota-bekasi-optimalkan-pelayanan-di-era-digital";
const res = await page.goto("http://127.0.0.1:4188/berita/" + slug, { waitUntil: "networkidle2", timeout: 30000 }).catch((e) => ({ e }));
console.log("status:", res && res.status ? res.status() : String(res && res.e));
await new Promise((r) => setTimeout(r, 1500));
console.log("title:", await page.title());
console.log("location:", await page.evaluate(() => location.pathname));
console.log("h1:", await page.evaluate(() => document.querySelector("h1")?.textContent?.slice(0, 80)));
await browser.close();
preview.kill();
process.exit(0);
