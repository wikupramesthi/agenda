import { spawn } from "node:child_process";
import puppeteer from "puppeteer-core";

const preview = spawn(process.execPath, ["node_modules/vite/bin/vite.js", "preview", "--port", "4191", "--strictPort"], { stdio: "ignore" });
await new Promise((r) => setTimeout(r, 2500));
const b = await puppeteer.launch({ executablePath: "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe", headless: "new", args: ["--no-sandbox"] });
const p = await b.newPage();
await p.goto("http://127.0.0.1:4191/berita/indek-kepuasan-masyarakat-triwuln-ke-ii-tahun-2026", { waitUntil: "networkidle2", timeout: 30000 });
await new Promise((r) => setTimeout(r, 1500));
console.log("pathname:", await p.evaluate(() => location.pathname));
console.log("lastRoute:", await p.evaluate(() => window.__lastRoute));
console.log("title:", await p.title());
await b.close();
preview.kill();
process.exit(0);
